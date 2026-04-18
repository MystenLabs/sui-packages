module 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::user_account {
    struct AccountRegistry has key {
        id: 0x2::object::UID,
        accounts: 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::KeyedBigVector,
        user_accounts: 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::KeyedBigVector,
    }

    struct UserAccount has store, key {
        id: 0x2::object::UID,
        owner_address: address,
        name: 0x1::string::String,
        delegates: vector<DelegateInfo>,
        positions: 0x2::vec_map::VecMap<0x2::object::ID, vector<u64>>,
        orders: 0x2::vec_map::VecMap<0x2::object::ID, vector<u64>>,
    }

    struct DelegateInfo has copy, drop, store {
        delegate_address: address,
        permissions: u16,
    }

    public fun account_account_id(arg0: &UserAccount) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun account_count(arg0: &AccountRegistry, arg1: address) : u64 {
        if (!0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::contains<address>(&arg0.user_accounts, arg1)) {
            return 0
        };
        0x1::vector::length<0x2::object::ID>(0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::borrow_by_key<address, vector<0x2::object::ID>>(&arg0.user_accounts, arg1))
    }

    public(friend) fun account_delegates(arg0: &UserAccount) : &vector<DelegateInfo> {
        &arg0.delegates
    }

    public fun account_ids(arg0: &AccountRegistry, arg1: address) : vector<0x2::object::ID> {
        if (!0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::contains<address>(&arg0.user_accounts, arg1)) {
            return 0x1::vector::empty<0x2::object::ID>()
        };
        *0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::borrow_by_key<address, vector<0x2::object::ID>>(&arg0.user_accounts, arg1)
    }

    public fun account_name(arg0: &UserAccount) : 0x1::string::String {
        arg0.name
    }

    public fun account_object_id(arg0: &AccountRegistry, arg1: 0x2::object::ID) : address {
        if (!0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::contains<0x2::object::ID>(&arg0.accounts, arg1)) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_sub_account_not_found();
        };
        0x2::object::id_to_address(&arg1)
    }

    public fun account_orders(arg0: &UserAccount) : &0x2::vec_map::VecMap<0x2::object::ID, vector<u64>> {
        &arg0.orders
    }

    public fun account_owner_address(arg0: &UserAccount) : address {
        arg0.owner_address
    }

    public fun account_positions(arg0: &UserAccount) : &0x2::vec_map::VecMap<0x2::object::ID, vector<u64>> {
        &arg0.positions
    }

    public fun add_delegate(arg0: &mut AccountRegistry, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: 0x2::object::ID, arg3: address, arg4: u16) {
        let v0 = borrow_mut_account_checked(arg0, arg2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1));
        let v1 = 0;
        while (v1 < 0x1::vector::length<DelegateInfo>(&v0.delegates)) {
            if (0x1::vector::borrow<DelegateInfo>(&v0.delegates, v1).delegate_address == arg3) {
                0x1::vector::swap_remove<DelegateInfo>(&mut v0.delegates, v1);
                break
            };
            v1 = v1 + 1;
        };
        let v2 = DelegateInfo{
            delegate_address : arg3,
            permissions      : arg4,
        };
        0x1::vector::push_back<DelegateInfo>(&mut v0.delegates, v2);
    }

    public(friend) fun add_order(arg0: &mut AccountRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64) {
        if (!0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::contains<0x2::object::ID>(&arg0.accounts, arg1)) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_sub_account_not_found();
        };
        let v0 = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::borrow_by_key_mut<0x2::object::ID, UserAccount>(&mut arg0.accounts, arg1);
        if (!0x2::vec_map::contains<0x2::object::ID, vector<u64>>(&v0.orders, &arg2)) {
            let v1 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v1, arg3);
            0x2::vec_map::insert<0x2::object::ID, vector<u64>>(&mut v0.orders, arg2, v1);
        } else {
            0x1::vector::push_back<u64>(0x2::vec_map::get_mut<0x2::object::ID, vector<u64>>(&mut v0.orders, &arg2), arg3);
        };
    }

    public(friend) fun add_position(arg0: &mut AccountRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64) {
        if (!0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::contains<0x2::object::ID>(&arg0.accounts, arg1)) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_sub_account_not_found();
        };
        let v0 = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::borrow_by_key_mut<0x2::object::ID, UserAccount>(&mut arg0.accounts, arg1);
        if (!0x2::vec_map::contains<0x2::object::ID, vector<u64>>(&v0.positions, &arg2)) {
            let v1 = 0x1::vector::empty<u64>();
            0x1::vector::push_back<u64>(&mut v1, arg3);
            0x2::vec_map::insert<0x2::object::ID, vector<u64>>(&mut v0.positions, arg2, v1);
        } else {
            0x1::vector::push_back<u64>(0x2::vec_map::get_mut<0x2::object::ID, vector<u64>>(&mut v0.positions, &arg2), arg3);
        };
    }

    public(friend) fun borrow_account(arg0: &AccountRegistry, arg1: 0x2::object::ID) : &UserAccount {
        if (!0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::contains<0x2::object::ID>(&arg0.accounts, arg1)) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_sub_account_not_found();
        };
        0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::borrow_by_key<0x2::object::ID, UserAccount>(&arg0.accounts, arg1)
    }

    fun borrow_mut_account_checked(arg0: &mut AccountRegistry, arg1: 0x2::object::ID, arg2: address) : &mut UserAccount {
        if (!0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::contains<0x2::object::ID>(&arg0.accounts, arg1)) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_sub_account_not_found();
        };
        let v0 = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::borrow_by_key_mut<0x2::object::ID, UserAccount>(&mut arg0.accounts, arg1);
        if (v0.owner_address != arg2) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_not_account_owner();
        };
        v0
    }

    public fun create_account(arg0: &mut AccountRegistry, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::object::ID {
        let v0 = 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1);
        if (0x1::string::length(&arg2) > 32) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_sub_account_name_too_long();
        };
        if (!0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::contains<address>(&arg0.user_accounts, v0)) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::push_back<address, vector<0x2::object::ID>>(&mut arg0.user_accounts, v0, 0x1::vector::empty<0x2::object::ID>());
        };
        if (0x1::vector::length<0x2::object::ID>(0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::borrow_by_key<address, vector<0x2::object::ID>>(&arg0.user_accounts, v0)) >= 20) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_max_sub_accounts_reached();
        };
        let v1 = UserAccount{
            id            : 0x2::object::new(arg4),
            owner_address : v0,
            name          : arg2,
            delegates     : 0x1::vector::empty<DelegateInfo>(),
            positions     : 0x2::vec_map::empty<0x2::object::ID, vector<u64>>(),
            orders        : 0x2::vec_map::empty<0x2::object::ID, vector<u64>>(),
        };
        let v2 = 0x2::object::uid_to_inner(&v1.id);
        0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::push_back<0x2::object::ID, UserAccount>(&mut arg0.accounts, v2, v1);
        0x1::vector::push_back<0x2::object::ID>(0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::borrow_by_key_mut<address, vector<0x2::object::ID>>(&mut arg0.user_accounts, v0), v2);
        0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::events::emit_account_created(v0, v2, 0x2::clock::timestamp_ms(arg3));
        v2
    }

    public(friend) fun delegate_info_address(arg0: &DelegateInfo) : address {
        arg0.delegate_address
    }

    public(friend) fun delegate_info_permissions(arg0: &DelegateInfo) : u16 {
        arg0.permissions
    }

    public fun delegate_permissions(arg0: &AccountRegistry, arg1: 0x2::object::ID, arg2: address) : u16 {
        if (!0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::contains<0x2::object::ID>(&arg0.accounts, arg1)) {
            return 0
        };
        let v0 = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::borrow_by_key<0x2::object::ID, UserAccount>(&arg0.accounts, arg1);
        if (v0.owner_address == arg2) {
            return 4095
        };
        let v1 = 0;
        while (v1 < 0x1::vector::length<DelegateInfo>(&v0.delegates)) {
            if (0x1::vector::borrow<DelegateInfo>(&v0.delegates, v1).delegate_address == arg2) {
                return 0x1::vector::borrow<DelegateInfo>(&v0.delegates, v1).permissions
            };
            v1 = v1 + 1;
        };
        0
    }

    public fun get_account_name(arg0: &AccountRegistry, arg1: 0x2::object::ID) : 0x1::string::String {
        if (!0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::contains<0x2::object::ID>(&arg0.accounts, arg1)) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_sub_account_not_found();
        };
        0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::borrow_by_key<0x2::object::ID, UserAccount>(&arg0.accounts, arg1).name
    }

    public fun get_account_owner(arg0: &AccountRegistry, arg1: 0x2::object::ID) : address {
        if (!0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::contains<0x2::object::ID>(&arg0.accounts, arg1)) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_sub_account_not_found();
        };
        0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::borrow_by_key<0x2::object::ID, UserAccount>(&arg0.accounts, arg1).owner_address
    }

    public fun has_account(arg0: &AccountRegistry, arg1: 0x2::object::ID) : bool {
        0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::contains<0x2::object::ID>(&arg0.accounts, arg1)
    }

    public fun has_accounts(arg0: &AccountRegistry, arg1: address) : bool {
        if (!0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::contains<address>(&arg0.user_accounts, arg1)) {
            return false
        };
        0x1::vector::length<0x2::object::ID>(0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::borrow_by_key<address, vector<0x2::object::ID>>(&arg0.user_accounts, arg1)) > 0
    }

    public fun has_permission(arg0: &AccountRegistry, arg1: 0x2::object::ID, arg2: address, arg3: u16) : bool {
        delegate_permissions(arg0, arg1, arg2) & arg3 == arg3
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AccountRegistry{
            id            : 0x2::object::new(arg0),
            accounts      : 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::new<0x2::object::ID, UserAccount>(256, arg0),
            user_accounts : 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::new<address, vector<0x2::object::ID>>(256, arg0),
        };
        0x2::transfer::share_object<AccountRegistry>(v0);
    }

    public fun is_authorized(arg0: &UserAccount, arg1: address) : bool {
        if (arg0.owner_address == arg1) {
            return true
        };
        let v0 = 0;
        while (v0 < 0x1::vector::length<DelegateInfo>(&arg0.delegates)) {
            if (0x1::vector::borrow<DelegateInfo>(&arg0.delegates, v0).delegate_address == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun perm_all() : u16 {
        4095
    }

    public fun perm_all_trading() : u16 {
        63
    }

    public fun perm_cancel_order() : u16 {
        8
    }

    public fun perm_close_position() : u16 {
        2
    }

    public fun perm_deposit() : u16 {
        64
    }

    public fun perm_deposit_collateral() : u16 {
        16
    }

    public fun perm_manage_delegates() : u16 {
        2048
    }

    public fun perm_mint_wlp() : u16 {
        512
    }

    public fun perm_open_position() : u16 {
        1
    }

    public fun perm_place_order() : u16 {
        4
    }

    public fun perm_redeem_wlp() : u16 {
        1024
    }

    public fun perm_transfer() : u16 {
        256
    }

    public fun perm_withdraw() : u16 {
        128
    }

    public fun perm_withdraw_collateral() : u16 {
        32
    }

    public(friend) fun receive_and_merge_internal<T0>(arg0: &mut AccountRegistry, arg1: 0x2::object::ID, arg2: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>, arg3: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, address) {
        if (!0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::contains<0x2::object::ID>(&arg0.accounts, arg1)) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_sub_account_not_found();
        };
        let v0 = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::borrow_by_key_mut<0x2::object::ID, UserAccount>(&mut arg0.accounts, arg1);
        let v1 = 0x2::coin::zero<T0>(arg3);
        0x1::vector::reverse<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&mut arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&arg2)) {
            0x2::coin::join<T0>(&mut v1, 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut v0.id, 0x1::vector::pop_back<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&mut arg2)));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(arg2);
        (v1, 0x2::object::uid_to_address(&v0.id))
    }

    public fun receive_coin_with_amount<T0>(arg0: &mut AccountRegistry, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: 0x2::object::ID, arg3: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>, arg4: 0x1::option::Option<u64>, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        if (!has_permission(arg0, arg2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1), 128)) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_unauthorized();
        };
        let v0 = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::borrow_by_key_mut<0x2::object::ID, UserAccount>(&mut arg0.accounts, arg2);
        let v1 = 0x2::coin::zero<T0>(arg5);
        0x1::vector::reverse<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&mut arg3);
        let v2 = 0;
        while (v2 < 0x1::vector::length<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&arg3)) {
            0x2::coin::join<T0>(&mut v1, 0x2::transfer::public_receive<0x2::coin::Coin<T0>>(&mut v0.id, 0x1::vector::pop_back<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(&mut arg3)));
            v2 = v2 + 1;
        };
        0x1::vector::destroy_empty<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>(arg3);
        let v3 = 0x1::option::destroy_with_default<u64>(arg4, 0x2::coin::value<T0>(&v1));
        if (v3 == 0 || v3 > 0x2::coin::value<T0>(&v1)) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_insufficient_balance();
        };
        if (0x2::coin::value<T0>(&v1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v1, 0x2::object::id_to_address(&arg2));
        } else {
            0x2::coin::destroy_zero<T0>(v1);
        };
        0x2::coin::split<T0>(&mut v1, v3, arg5)
    }

    public fun receive_coin_with_amount_to<T0>(arg0: &mut AccountRegistry, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: 0x2::object::ID, arg3: vector<0x2::transfer::Receiving<0x2::coin::Coin<T0>>>, arg4: 0x1::option::Option<u64>, arg5: address, arg6: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(receive_coin_with_amount<T0>(arg0, arg1, arg2, arg3, arg4, arg6), arg5);
    }

    public fun remove_delegate(arg0: &mut AccountRegistry, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: 0x2::object::ID, arg3: address) {
        let v0 = borrow_mut_account_checked(arg0, arg2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1));
        let v1 = 0;
        while (v1 < 0x1::vector::length<DelegateInfo>(&v0.delegates)) {
            if (0x1::vector::borrow<DelegateInfo>(&v0.delegates, v1).delegate_address == arg3) {
                0x1::vector::swap_remove<DelegateInfo>(&mut v0.delegates, v1);
                return
            };
            v1 = v1 + 1;
        };
    }

    public(friend) fun remove_order(arg0: &mut AccountRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64) {
        if (!0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::contains<0x2::object::ID>(&arg0.accounts, arg1)) {
            return
        };
        let v0 = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::borrow_by_key_mut<0x2::object::ID, UserAccount>(&mut arg0.accounts, arg1);
        if (!0x2::vec_map::contains<0x2::object::ID, vector<u64>>(&v0.orders, &arg2)) {
            return
        };
        let v1 = 0x2::vec_map::get_mut<0x2::object::ID, vector<u64>>(&mut v0.orders, &arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(v1)) {
            if (*0x1::vector::borrow<u64>(v1, v2) == arg3) {
                0x1::vector::swap_remove<u64>(v1, v2);
                return
            };
            v2 = v2 + 1;
        };
    }

    public(friend) fun remove_position(arg0: &mut AccountRegistry, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64) {
        if (!0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::contains<0x2::object::ID>(&arg0.accounts, arg1)) {
            0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_sub_account_not_found();
        };
        let v0 = 0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::keyed_big_vector::borrow_by_key_mut<0x2::object::ID, UserAccount>(&mut arg0.accounts, arg1);
        if (!0x2::vec_map::contains<0x2::object::ID, vector<u64>>(&v0.positions, &arg2)) {
            return
        };
        let v1 = 0x2::vec_map::get_mut<0x2::object::ID, vector<u64>>(&mut v0.positions, &arg2);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(v1)) {
            if (*0x1::vector::borrow<u64>(v1, v2) == arg3) {
                0x1::vector::swap_remove<u64>(v1, v2);
                return
            };
            v2 = v2 + 1;
        };
    }

    public fun transfer_coin<T0>(arg0: &AccountRegistry, arg1: 0x2::object::ID, arg2: 0x2::coin::Coin<T0>) {
        if (0x2::coin::value<T0>(&arg2) > 0) {
            if (!has_account(arg0, arg1)) {
                0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_sub_account_not_found();
            };
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg2, 0x2::object::id_to_address(&arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg2);
        };
    }

    public fun update_delegate_permissions(arg0: &mut AccountRegistry, arg1: &0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::AccountRequest, arg2: 0x2::object::ID, arg3: address, arg4: u16) {
        let v0 = borrow_mut_account_checked(arg0, arg2, 0x665188033384920a5bb5dcfb2ef21f54b4568d08b431718b97e02e5c184b92cc::account::request_address(arg1));
        let v1 = 0;
        while (v1 < 0x1::vector::length<DelegateInfo>(&v0.delegates)) {
            if (0x1::vector::borrow<DelegateInfo>(&v0.delegates, v1).delegate_address == arg3) {
                0x1::vector::borrow_mut<DelegateInfo>(&mut v0.delegates, v1).permissions = arg4;
                return
            };
            v1 = v1 + 1;
        };
        0x17235897a9c2e977d60f3ded7b05e85724d7ee846b1519e6d8af7fdbc840da37::error::err_sub_account_not_found();
    }

    // decompiled from Move bytecode v7
}

