module 0xee2d1415203488e1ea0b0697b4c579685ba8702b8fa8cef3da27ab6faf227b7e::vault {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct PauserCap has store, key {
        id: 0x2::object::UID,
    }

    struct OperatorCap has key {
        id: 0x2::object::UID,
        vault_id: 0x2::object::ID,
    }

    struct ArcadeVault has key {
        id: 0x2::object::UID,
        version: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        signer_pubkey: vector<u8>,
        paused: bool,
        min_deposit: u64,
        max_deposit_per_tx: u64,
        tvl_cap: u64,
        max_withdraw_per_tx: u64,
        daily_outflow_cap: u64,
        window_start_ms: u64,
        window_outflow: u64,
        total_deposited: u64,
        total_withdrawn: u64,
        house_deposited: u64,
        house_withdrawn: u64,
        users: 0x2::table::Table<address, UserState>,
    }

    struct UserState has store {
        next_nonce: u64,
        cum_deposited: u64,
        cum_withdrawn: u64,
    }

    struct WithdrawVoucher has copy, drop {
        domain: vector<u8>,
        vault_id: 0x2::object::ID,
        user: address,
        amount: u64,
        nonce: u64,
        expiry_ms: u64,
    }

    struct VaultCreated has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct Deposited has copy, drop {
        vault_id: 0x2::object::ID,
        user: address,
        amount: u64,
        total_deposited: u64,
    }

    struct Withdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        user: address,
        amount: u64,
        nonce: u64,
        total_withdrawn: u64,
    }

    struct HouseDeposited has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        house_deposited: u64,
    }

    struct HouseWithdrawn has copy, drop {
        vault_id: 0x2::object::ID,
        amount: u64,
        house_withdrawn: u64,
    }

    struct Paused has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct Unpaused has copy, drop {
        vault_id: 0x2::object::ID,
    }

    struct SignerRotated has copy, drop {
        vault_id: 0x2::object::ID,
        signer_pubkey: vector<u8>,
    }

    struct LimitsUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        min_deposit: u64,
        max_deposit_per_tx: u64,
        tvl_cap: u64,
        max_withdraw_per_tx: u64,
        daily_outflow_cap: u64,
    }

    struct VaultMigrated has copy, drop {
        vault_id: 0x2::object::ID,
        from_version: u64,
        to_version: u64,
    }

    struct OperatorCapIssued has copy, drop {
        vault_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
        holder: address,
    }

    struct OperatorCapRevoked has copy, drop {
        vault_id: 0x2::object::ID,
        cap_id: 0x2::object::ID,
    }

    public(friend) fun assert_admin_current(arg0: &AdminCap) {
        assert!(arg0.version == 1, 1);
    }

    fun assert_current_version(arg0: &ArcadeVault) {
        assert!(arg0.version == 1, 1);
    }

    fun assert_operator(arg0: &OperatorCap, arg1: &ArcadeVault) {
        assert!(is_operator(arg1, 0x2::object::id<OperatorCap>(arg0)), 16);
    }

    fun assert_public_key(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 33, 12);
        let v0 = *0x1::vector::borrow<u8>(arg0, 0);
        assert!(v0 == 2 || v0 == 3, 12);
    }

    public(friend) fun assert_vault_current(arg0: &ArcadeVault) {
        assert_current_version(arg0);
    }

    public fun balance_value(arg0: &ArcadeVault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    fun charge_outflow(arg0: &mut ArcadeVault, arg1: u64) {
        let v0 = arg0.window_outflow + arg1;
        assert!(v0 <= arg0.daily_outflow_cap, 7);
        arg0.window_outflow = v0;
    }

    public fun create_vault(arg0: &AdminCap, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        assert_admin_current(arg0);
        assert_public_key(&arg1);
        let v0 = ArcadeVault{
            id                  : 0x2::object::new(arg7),
            version             : 1,
            balance             : 0x2::balance::zero<0x2::sui::SUI>(),
            signer_pubkey       : arg1,
            paused              : false,
            min_deposit         : arg2,
            max_deposit_per_tx  : arg3,
            tvl_cap             : arg4,
            max_withdraw_per_tx : arg5,
            daily_outflow_cap   : arg6,
            window_start_ms     : 0,
            window_outflow      : 0,
            total_deposited     : 0,
            total_withdrawn     : 0,
            house_deposited     : 0,
            house_withdrawn     : 0,
            users               : 0x2::table::new<address, UserState>(arg7),
        };
        let v1 = VaultCreated{vault_id: 0x2::object::id<ArcadeVault>(&v0)};
        0x2::event::emit<VaultCreated>(v1);
        0x2::transfer::share_object<ArcadeVault>(v0);
    }

    fun credit_house(arg0: &mut ArcadeVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 15);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.house_deposited = arg0.house_deposited + v0;
        let v1 = HouseDeposited{
            vault_id        : 0x2::object::id<ArcadeVault>(arg0),
            amount          : v0,
            house_deposited : arg0.house_deposited,
        };
        0x2::event::emit<HouseDeposited>(v1);
    }

    public fun deposit(arg0: &mut ArcadeVault, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_current_version(arg0);
        assert!(!arg0.paused, 2);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v0 > 0, 15);
        assert!(v0 >= arg0.min_deposit, 9);
        assert!(v0 <= arg0.max_deposit_per_tx, 10);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg0.balance) + v0 <= arg0.tvl_cap, 11);
        let v1 = 0x2::tx_context::sender(arg2);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_deposited = arg0.total_deposited + v0;
        let v2 = user_state_mut(arg0, v1);
        v2.cum_deposited = v2.cum_deposited + v0;
        let v3 = Deposited{
            vault_id        : 0x2::object::id<ArcadeVault>(arg0),
            user            : v1,
            amount          : v0,
            total_deposited : arg0.total_deposited,
        };
        0x2::event::emit<Deposited>(v3);
    }

    public fun house_deposit(arg0: &AdminCap, arg1: &mut ArcadeVault, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert_current_version(arg1);
        credit_house(arg1, arg2);
    }

    public fun house_withdraw(arg0: &AdminCap, arg1: &mut ArcadeVault, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_current_version(arg1);
        assert!(arg2 > 0, 15);
        roll_outflow_window(arg1, 0x2::clock::timestamp_ms(arg3));
        charge_outflow(arg1, arg2);
        assert!(arg2 <= 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), 8);
        arg1.house_withdrawn = arg1.house_withdrawn + arg2;
        let v0 = HouseWithdrawn{
            vault_id        : 0x2::object::id<ArcadeVault>(arg1),
            amount          : arg2,
            house_withdrawn : arg1.house_withdrawn,
        };
        0x2::event::emit<HouseWithdrawn>(v0);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, arg2), arg4)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{
            id      : 0x2::object::new(arg0),
            version : 1,
        };
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = PauserCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<PauserCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun is_operator(arg0: &ArcadeVault, arg1: 0x2::object::ID) : bool {
        0x2::dynamic_field::exists_with_type<0x2::object::ID, address>(&arg0.id, arg1)
    }

    public fun issue_operator_cap(arg0: &AdminCap, arg1: &mut ArcadeVault, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_current_version(arg1);
        let v0 = OperatorCap{
            id       : 0x2::object::new(arg3),
            vault_id : 0x2::object::id<ArcadeVault>(arg1),
        };
        let v1 = 0x2::object::id<OperatorCap>(&v0);
        0x2::dynamic_field::add<0x2::object::ID, address>(&mut arg1.id, v1, arg2);
        let v2 = OperatorCapIssued{
            vault_id : 0x2::object::id<ArcadeVault>(arg1),
            cap_id   : v1,
            holder   : arg2,
        };
        0x2::event::emit<OperatorCapIssued>(v2);
        0x2::transfer::transfer<OperatorCap>(v0, arg2);
    }

    public fun migrate(arg0: &mut AdminCap, arg1: &mut ArcadeVault) {
        assert!(arg1.version < 1, 14);
        assert!(arg0.version <= 1, 14);
        arg1.version = 1;
        arg0.version = 1;
        let v0 = VaultMigrated{
            vault_id     : 0x2::object::id<ArcadeVault>(arg1),
            from_version : arg1.version,
            to_version   : 1,
        };
        0x2::event::emit<VaultMigrated>(v0);
    }

    public fun next_nonce(arg0: &ArcadeVault, arg1: address) : u64 {
        if (0x2::table::contains<address, UserState>(&arg0.users, arg1)) {
            0x2::table::borrow<address, UserState>(&arg0.users, arg1).next_nonce
        } else {
            0
        }
    }

    public fun operator_house_deposit(arg0: &OperatorCap, arg1: &mut ArcadeVault, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        assert_current_version(arg1);
        assert_operator(arg0, arg1);
        credit_house(arg1, arg2);
    }

    public fun operator_tighten_limits(arg0: &OperatorCap, arg1: &mut ArcadeVault, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        assert_current_version(arg1);
        assert_operator(arg0, arg1);
        assert!(arg2 <= arg1.max_deposit_per_tx, 17);
        assert!(arg3 <= arg1.tvl_cap, 17);
        assert!(arg4 <= arg1.max_withdraw_per_tx, 17);
        assert!(arg5 <= arg1.daily_outflow_cap, 17);
        arg1.max_deposit_per_tx = arg2;
        arg1.tvl_cap = arg3;
        arg1.max_withdraw_per_tx = arg4;
        arg1.daily_outflow_cap = arg5;
        let v0 = LimitsUpdated{
            vault_id            : 0x2::object::id<ArcadeVault>(arg1),
            min_deposit         : arg1.min_deposit,
            max_deposit_per_tx  : arg2,
            tvl_cap             : arg3,
            max_withdraw_per_tx : arg4,
            daily_outflow_cap   : arg5,
        };
        0x2::event::emit<LimitsUpdated>(v0);
    }

    public fun pause(arg0: &PauserCap, arg1: &mut ArcadeVault) {
        assert_current_version(arg1);
        arg1.paused = true;
        let v0 = Paused{vault_id: 0x2::object::id<ArcadeVault>(arg1)};
        0x2::event::emit<Paused>(v0);
    }

    fun redeem_voucher(arg0: &mut ArcadeVault, arg1: u64, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        assert_current_version(arg0);
        assert!(!arg0.paused, 2);
        assert!(arg1 > 0, 15);
        assert!(0x1::vector::length<u8>(&arg4) == 64, 13);
        let v0 = 0x2::tx_context::sender(arg6);
        let v1 = voucher_message(arg0, v0, arg1, arg2, arg3);
        assert!(0x2::ecdsa_k1::secp256k1_verify(&arg4, &arg0.signer_pubkey, &v1, 1), 3);
        assert!(arg2 == next_nonce(arg0, v0), 4);
        let v2 = 0x2::clock::timestamp_ms(arg5);
        assert!(v2 < arg3, 5);
        assert!(arg1 <= arg0.max_withdraw_per_tx, 6);
        roll_outflow_window(arg0, v2);
        charge_outflow(arg0, arg1);
        assert!(arg1 <= 0x2::balance::value<0x2::sui::SUI>(&arg0.balance), 8);
        arg0.total_withdrawn = arg0.total_withdrawn + arg1;
        let v3 = user_state_mut(arg0, v0);
        v3.next_nonce = v3.next_nonce + 1;
        v3.cum_withdrawn = v3.cum_withdrawn + arg1;
        let v4 = Withdrawn{
            vault_id        : 0x2::object::id<ArcadeVault>(arg0),
            user            : v0,
            amount          : arg1,
            nonce           : arg2,
            total_withdrawn : arg0.total_withdrawn,
        };
        0x2::event::emit<Withdrawn>(v4);
        0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.balance, arg1), arg6)
    }

    public fun revoke_operator_cap(arg0: &AdminCap, arg1: &mut ArcadeVault, arg2: 0x2::object::ID) {
        assert_current_version(arg1);
        assert!(0x2::dynamic_field::exists_with_type<0x2::object::ID, address>(&arg1.id, arg2), 16);
        0x2::dynamic_field::remove<0x2::object::ID, address>(&mut arg1.id, arg2);
        let v0 = OperatorCapRevoked{
            vault_id : 0x2::object::id<ArcadeVault>(arg1),
            cap_id   : arg2,
        };
        0x2::event::emit<OperatorCapRevoked>(v0);
    }

    fun roll_outflow_window(arg0: &mut ArcadeVault, arg1: u64) {
        if (arg1 >= arg0.window_start_ms + 86400000) {
            arg0.window_start_ms = arg1;
            arg0.window_outflow = 0;
        };
    }

    public fun set_limits(arg0: &AdminCap, arg1: &mut ArcadeVault, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert_current_version(arg1);
        arg1.min_deposit = arg2;
        arg1.max_deposit_per_tx = arg3;
        arg1.tvl_cap = arg4;
        arg1.max_withdraw_per_tx = arg5;
        arg1.daily_outflow_cap = arg6;
        let v0 = LimitsUpdated{
            vault_id            : 0x2::object::id<ArcadeVault>(arg1),
            min_deposit         : arg2,
            max_deposit_per_tx  : arg3,
            tvl_cap             : arg4,
            max_withdraw_per_tx : arg5,
            daily_outflow_cap   : arg6,
        };
        0x2::event::emit<LimitsUpdated>(v0);
    }

    public fun set_signer(arg0: &AdminCap, arg1: &mut ArcadeVault, arg2: vector<u8>) {
        assert_current_version(arg1);
        assert_public_key(&arg2);
        arg1.signer_pubkey = arg2;
        let v0 = SignerRotated{
            vault_id      : 0x2::object::id<ArcadeVault>(arg1),
            signer_pubkey : arg2,
        };
        0x2::event::emit<SignerRotated>(v0);
    }

    public(friend) fun uid(arg0: &ArcadeVault) : &0x2::object::UID {
        &arg0.id
    }

    public(friend) fun uid_mut(arg0: &mut ArcadeVault) : &mut 0x2::object::UID {
        &mut arg0.id
    }

    public fun unpause(arg0: &AdminCap, arg1: &mut ArcadeVault) {
        assert_current_version(arg1);
        arg1.paused = false;
        let v0 = Unpaused{vault_id: 0x2::object::id<ArcadeVault>(arg1)};
        0x2::event::emit<Unpaused>(v0);
    }

    fun user_state_mut(arg0: &mut ArcadeVault, arg1: address) : &mut UserState {
        if (!0x2::table::contains<address, UserState>(&arg0.users, arg1)) {
            let v0 = UserState{
                next_nonce    : 0,
                cum_deposited : 0,
                cum_withdrawn : 0,
            };
            0x2::table::add<address, UserState>(&mut arg0.users, arg1, v0);
        };
        0x2::table::borrow_mut<address, UserState>(&mut arg0.users, arg1)
    }

    public fun voucher_bytes(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) : vector<u8> {
        let v0 = WithdrawVoucher{
            domain    : b"YOSO_ARCADE_WITHDRAW_V1",
            vault_id  : arg0,
            user      : arg1,
            amount    : arg2,
            nonce     : arg3,
            expiry_ms : arg4,
        };
        0x2::bcs::to_bytes<WithdrawVoucher>(&v0)
    }

    public fun voucher_message(arg0: &ArcadeVault, arg1: address, arg2: u64, arg3: u64, arg4: u64) : vector<u8> {
        voucher_bytes(0x2::object::id<ArcadeVault>(arg0), arg1, arg2, arg3, arg4)
    }

    entry fun withdraw(arg0: &mut ArcadeVault, arg1: u64, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = redeem_voucher(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(v0, 0x2::tx_context::sender(arg6));
    }

    public fun withdraw_to_coin(arg0: &mut ArcadeVault, arg1: u64, arg2: u64, arg3: u64, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        redeem_voucher(arg0, arg1, arg2, arg3, arg4, arg5, arg6)
    }

    // decompiled from Move bytecode v7
}

