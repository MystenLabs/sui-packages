module 0x74cb720638f4149ae48514041809d66bbdc7f1d5e40c01137ddf02d585d0ce17::CLAIM {
    struct ClaimEvent has copy, drop {
        user: address,
    }

    struct CreateClaimEvent has copy, drop {
        id: 0x2::object::ID,
        owner: address,
    }

    struct AddUsersEvent has copy, drop {
        state_id: 0x2::object::ID,
        addresses: vector<address>,
        sui_amounts: vector<u64>,
        token_amounts: vector<u64>,
    }

    struct RemoveUsersEvent has copy, drop {
        state_id: 0x2::object::ID,
        addresses: vector<address>,
    }

    struct UserInfo has drop, store {
        sui_amount: u64,
        token_amount: u64,
        claimed: bool,
    }

    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct PoolState<phantom T0> has key {
        id: 0x2::object::UID,
        paused: bool,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
        token_balance: 0x2::balance::Balance<T0>,
        users: 0x2::table::Table<address, UserInfo>,
        owner: address,
    }

    public entry fun add_users<T0>(arg0: &mut PoolState<T0>, arg1: vector<address>, arg2: vector<u64>, arg3: vector<u64>, arg4: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, 0x2::tx_context::sender(arg4));
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u64>(&arg2) && 0x1::vector::length<u64>(&arg2) == 0x1::vector::length<u64>(&arg3), 4);
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (!0x2::table::contains<address, UserInfo>(&arg0.users, v1)) {
                let v2 = UserInfo{
                    sui_amount   : *0x1::vector::borrow<u64>(&arg2, v0),
                    token_amount : *0x1::vector::borrow<u64>(&arg3, v0),
                    claimed      : false,
                };
                0x2::table::add<address, UserInfo>(&mut arg0.users, v1, v2);
            } else {
                let v3 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, v1);
                v3.sui_amount = *0x1::vector::borrow<u64>(&arg2, v0);
                v3.token_amount = *0x1::vector::borrow<u64>(&arg3, v0);
            };
            v0 = v0 + 1;
        };
        let v4 = AddUsersEvent{
            state_id      : 0x2::object::uid_to_inner(&arg0.id),
            addresses     : arg1,
            sui_amounts   : arg2,
            token_amounts : arg3,
        };
        0x2::event::emit<AddUsersEvent>(v4);
    }

    fun assert_not_paused<T0>(arg0: &PoolState<T0>) {
        assert!(!arg0.paused, 3);
    }

    fun assert_owner<T0>(arg0: &PoolState<T0>, arg1: address) {
        assert!(arg1 == arg0.owner, 0);
    }

    public entry fun claim<T0>(arg0: &mut PoolState<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        assert_not_paused<T0>(arg0);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, UserInfo>(&arg0.users, v0), 1);
        let v1 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg0.users, v0);
        assert!(!v1.claimed, 2);
        v1.claimed = true;
        if (v1.sui_amount > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, v1.sui_amount), arg1), v0);
        };
        if (v1.token_amount > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_balance, v1.token_amount), arg1), v0);
        };
        let v2 = ClaimEvent{user: v0};
        0x2::event::emit<ClaimEvent>(v2);
    }

    public entry fun create_claim<T0>(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg2);
        let v1 = CreateClaimEvent{
            id    : 0x2::object::uid_to_inner(&v0),
            owner : arg1,
        };
        0x2::event::emit<CreateClaimEvent>(v1);
        let v2 = PoolState<T0>{
            id            : v0,
            paused        : true,
            sui_balance   : 0x2::balance::zero<0x2::sui::SUI>(),
            token_balance : 0x2::balance::zero<T0>(),
            users         : 0x2::table::new<address, UserInfo>(arg2),
            owner         : arg1,
        };
        0x2::transfer::share_object<PoolState<T0>>(v2);
    }

    public fun deposit_sui<T0>(arg0: &mut PoolState<T0>, arg1: 0x2::balance::Balance<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, 0x2::tx_context::sender(arg2));
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, arg1);
    }

    public fun deposit_token<T0>(arg0: &mut PoolState<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, 0x2::tx_context::sender(arg2));
        0x2::balance::join<T0>(&mut arg0.token_balance, arg1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun remove_users<T0>(arg0: &mut PoolState<T0>, arg1: vector<address>, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, 0x2::tx_context::sender(arg2));
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg1)) {
            let v1 = *0x1::vector::borrow<address>(&arg1, v0);
            if (0x2::table::contains<address, UserInfo>(&arg0.users, v1)) {
                0x2::table::remove<address, UserInfo>(&mut arg0.users, v1);
            };
            v0 = v0 + 1;
        };
        let v2 = RemoveUsersEvent{
            state_id  : 0x2::object::uid_to_inner(&arg0.id),
            addresses : arg1,
        };
        0x2::event::emit<RemoveUsersEvent>(v2);
    }

    public entry fun toggle_pause<T0>(arg0: &mut PoolState<T0>, arg1: &0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, 0x2::tx_context::sender(arg1));
        arg0.paused = !arg0.paused;
    }

    public entry fun withdraw_sui<T0>(arg0: &mut PoolState<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.sui_balance, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_token<T0>(arg0: &mut PoolState<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert_owner<T0>(arg0, 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg0.token_balance, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

