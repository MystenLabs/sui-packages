module 0x1db3a54b99c2741bf8b8aaa8266d6e7b6daf0c702a5ef5b0d6e9e6cf12527a90::gateway {
    struct Vault<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        whitelisted: bool,
    }

    struct Gateway has key {
        id: 0x2::object::UID,
        vaults: 0x2::bag::Bag,
        nonce: u64,
        active_withdraw_cap: 0x2::object::ID,
        active_whitelist_cap: 0x2::object::ID,
        deposit_paused: bool,
    }

    struct WithdrawCap has store, key {
        id: 0x2::object::UID,
    }

    struct WhitelistCap has store, key {
        id: 0x2::object::UID,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DepositEvent has copy, drop {
        coin_type: 0x1::ascii::String,
        amount: u64,
        sender: address,
        receiver: 0x1::ascii::String,
    }

    struct DepositAndCallEvent has copy, drop {
        coin_type: 0x1::ascii::String,
        amount: u64,
        sender: address,
        receiver: 0x1::ascii::String,
        payload: vector<u8>,
    }

    struct WithdrawEvent has copy, drop {
        coin_type: 0x1::ascii::String,
        amount: u64,
        sender: address,
        receiver: address,
        nonce: u64,
    }

    struct NonceIncreaseEvent has copy, drop {
        sender: address,
        nonce: u64,
    }

    public fun active_whitelist_cap(arg0: &Gateway) : 0x2::object::ID {
        arg0.active_whitelist_cap
    }

    public fun active_withdraw_cap(arg0: &Gateway) : 0x2::object::ID {
        arg0.active_withdraw_cap
    }

    fun check_receiver_and_deposit_to_vault<T0>(arg0: &mut Gateway, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::ascii::String) {
        assert!(0x1db3a54b99c2741bf8b8aaa8266d6e7b6daf0c702a5ef5b0d6e9e6cf12527a90::evm::is_valid_evm_address(arg2), 1);
        assert!(is_whitelisted<T0>(arg0), 2);
        assert!(!arg0.deposit_paused, 7);
        0x2::balance::join<T0>(&mut 0x2::bag::borrow_mut<0x1::ascii::String, Vault<T0>>(&mut arg0.vaults, coin_name<T0>()).balance, 0x2::coin::into_balance<T0>(arg1));
    }

    fun coin_name<T0>() : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::get<T0>())
    }

    public entry fun deposit<T0>(arg0: &mut Gateway, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::ascii::String, arg3: &mut 0x2::tx_context::TxContext) {
        check_receiver_and_deposit_to_vault<T0>(arg0, arg1, arg2);
        let v0 = DepositEvent{
            coin_type : coin_name<T0>(),
            amount    : 0x2::coin::value<T0>(&arg1),
            sender    : 0x2::tx_context::sender(arg3),
            receiver  : arg2,
        };
        0x2::event::emit<DepositEvent>(v0);
    }

    public entry fun deposit_and_call<T0>(arg0: &mut Gateway, arg1: 0x2::coin::Coin<T0>, arg2: 0x1::ascii::String, arg3: vector<u8>, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg3) <= 1024, 4);
        check_receiver_and_deposit_to_vault<T0>(arg0, arg1, arg2);
        let v0 = DepositAndCallEvent{
            coin_type : coin_name<T0>(),
            amount    : 0x2::coin::value<T0>(&arg1),
            sender    : 0x2::tx_context::sender(arg4),
            receiver  : arg2,
            payload   : arg3,
        };
        0x2::event::emit<DepositAndCallEvent>(v0);
    }

    entry fun increase_nonce(arg0: &mut Gateway, arg1: u64, arg2: &WithdrawCap, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.active_withdraw_cap == 0x2::object::id<WithdrawCap>(arg2), 5);
        assert!(arg1 == arg0.nonce, 3);
        arg0.nonce = arg1 + 1;
        let v0 = NonceIncreaseEvent{
            sender : 0x2::tx_context::sender(arg3),
            nonce  : arg0.nonce,
        };
        0x2::event::emit<NonceIncreaseEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = WithdrawCap{id: 0x2::object::new(arg0)};
        let v1 = WhitelistCap{id: 0x2::object::new(arg0)};
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        let v3 = Gateway{
            id                   : 0x2::object::new(arg0),
            vaults               : 0x2::bag::new(arg0),
            nonce                : 0,
            active_withdraw_cap  : 0x2::object::id<WithdrawCap>(&v0),
            active_whitelist_cap : 0x2::object::id<WhitelistCap>(&v1),
            deposit_paused       : false,
        };
        let v4 = &mut v3;
        whitelist_impl<0x2::sui::SUI>(v4, &v1);
        0x2::transfer::transfer<WithdrawCap>(v0, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<WhitelistCap>(v1, 0x2::tx_context::sender(arg0));
        0x2::transfer::transfer<AdminCap>(v2, 0x2::tx_context::sender(arg0));
        0x2::transfer::share_object<Gateway>(v3);
    }

    public fun is_paused(arg0: &Gateway) : bool {
        arg0.deposit_paused
    }

    public fun is_whitelisted<T0>(arg0: &Gateway) : bool {
        let v0 = coin_name<T0>();
        if (!0x2::bag::contains_with_type<0x1::ascii::String, Vault<T0>>(&arg0.vaults, v0)) {
            return false
        };
        0x2::bag::borrow<0x1::ascii::String, Vault<T0>>(&arg0.vaults, v0).whitelisted
    }

    entry fun issue_withdraw_and_whitelist_cap(arg0: &mut Gateway, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = issue_withdraw_and_whitelist_cap_impl(arg0, arg1, arg2);
        0x2::transfer::transfer<WithdrawCap>(v0, 0x2::tx_context::sender(arg2));
        0x2::transfer::transfer<WhitelistCap>(v1, 0x2::tx_context::sender(arg2));
    }

    public fun issue_withdraw_and_whitelist_cap_impl(arg0: &mut Gateway, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) : (WithdrawCap, WhitelistCap) {
        let v0 = WithdrawCap{id: 0x2::object::new(arg2)};
        let v1 = WhitelistCap{id: 0x2::object::new(arg2)};
        arg0.active_withdraw_cap = 0x2::object::id<WithdrawCap>(&v0);
        arg0.active_whitelist_cap = 0x2::object::id<WhitelistCap>(&v1);
        (v0, v1)
    }

    public fun nonce(arg0: &Gateway) : u64 {
        arg0.nonce
    }

    entry fun pause(arg0: &mut Gateway, arg1: &AdminCap) {
        pause_impl(arg0, arg1);
    }

    public fun pause_impl(arg0: &mut Gateway, arg1: &AdminCap) {
        arg0.deposit_paused = true;
    }

    entry fun reset_nonce(arg0: &mut Gateway, arg1: u64, arg2: &AdminCap) {
        arg0.nonce = arg1;
    }

    entry fun unpause(arg0: &mut Gateway, arg1: &AdminCap) {
        unpause_impl(arg0, arg1);
    }

    public fun unpause_impl(arg0: &mut Gateway, arg1: &AdminCap) {
        arg0.deposit_paused = false;
    }

    entry fun unwhitelist<T0>(arg0: &mut Gateway, arg1: &AdminCap) {
        unwhitelist_impl<T0>(arg0, arg1);
    }

    public fun unwhitelist_impl<T0>(arg0: &mut Gateway, arg1: &AdminCap) {
        assert!(is_whitelisted<T0>(arg0), 2);
        0x2::bag::borrow_mut<0x1::ascii::String, Vault<T0>>(&mut arg0.vaults, coin_name<T0>()).whitelisted = false;
    }

    public fun vault_balance<T0>(arg0: &Gateway) : u64 {
        if (!is_whitelisted<T0>(arg0)) {
            return 0
        };
        0x2::balance::value<T0>(&0x2::bag::borrow<0x1::ascii::String, Vault<T0>>(&arg0.vaults, coin_name<T0>()).balance)
    }

    entry fun whitelist<T0>(arg0: &mut Gateway, arg1: &WhitelistCap) {
        whitelist_impl<T0>(arg0, arg1);
    }

    public fun whitelist_impl<T0>(arg0: &mut Gateway, arg1: &WhitelistCap) {
        assert!(arg0.active_whitelist_cap == 0x2::object::id<WhitelistCap>(arg1), 6);
        assert!(is_whitelisted<T0>(arg0) == false, 0);
        if (0x2::bag::contains_with_type<0x1::ascii::String, Vault<T0>>(&arg0.vaults, coin_name<T0>())) {
            0x2::bag::borrow_mut<0x1::ascii::String, Vault<T0>>(&mut arg0.vaults, coin_name<T0>()).whitelisted = true;
        } else {
            let v0 = Vault<T0>{
                balance     : 0x2::balance::zero<T0>(),
                whitelisted : true,
            };
            0x2::bag::add<0x1::ascii::String, Vault<T0>>(&mut arg0.vaults, coin_name<T0>(), v0);
        };
    }

    entry fun withdraw<T0>(arg0: &mut Gateway, arg1: u64, arg2: u64, arg3: address, arg4: u64, arg5: &WithdrawCap, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = withdraw_impl<T0>(arg0, arg1, arg2, arg4, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v0, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v1, 0x2::tx_context::sender(arg6));
        let v2 = WithdrawEvent{
            coin_type : coin_name<T0>(),
            amount    : arg1,
            sender    : 0x2::tx_context::sender(arg6),
            receiver  : arg3,
            nonce     : arg2,
        };
        0x2::event::emit<WithdrawEvent>(v2);
    }

    public fun withdraw_impl<T0>(arg0: &mut Gateway, arg1: u64, arg2: u64, arg3: u64, arg4: &WithdrawCap, arg5: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(arg0.active_withdraw_cap == 0x2::object::id<WithdrawCap>(arg4), 5);
        assert!(is_whitelisted<T0>(arg0), 2);
        assert!(arg2 == arg0.nonce, 3);
        arg0.nonce = arg2 + 1;
        (0x2::coin::take<T0>(&mut 0x2::bag::borrow_mut<0x1::ascii::String, Vault<T0>>(&mut arg0.vaults, coin_name<T0>()).balance, arg1, arg5), 0x2::coin::take<0x2::sui::SUI>(&mut 0x2::bag::borrow_mut<0x1::ascii::String, Vault<0x2::sui::SUI>>(&mut arg0.vaults, coin_name<0x2::sui::SUI>()).balance, arg3, arg5))
    }

    // decompiled from Move bytecode v6
}

