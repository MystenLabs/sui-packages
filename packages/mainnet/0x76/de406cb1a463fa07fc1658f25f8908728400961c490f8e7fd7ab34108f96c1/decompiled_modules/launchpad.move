module 0xfcd83ed778b511e9cfaade512b04d60f562869106a4c052660b803e66a4b723f::launchpad {
    struct OwnerCap has store, key {
        id: 0x2::object::UID,
    }

    struct Pool<phantom T0> has store {
        balance: 0x2::balance::Balance<T0>,
        amount: u64,
        max_amount: u64,
        payments: u64,
        open_at: u64,
        close_at: u64,
    }

    struct UserInfo has copy, store {
        private_amount: u64,
        public_amount: u64,
        claimed: bool,
    }

    struct Launchpool<phantom T0, phantom T1> has store, key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        private_pool: Pool<T1>,
        public_pool: Pool<T1>,
        creator: address,
        is_claimed: bool,
        amount: u64,
        users: 0x2::table::Table<address, UserInfo>,
        claim_at: u64,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        paused: bool,
        fee_rate: u64,
        owner: address,
        pools: 0x2::table::Table<u64, 0x2::object::ID>,
    }

    struct WhiteList has key {
        id: 0x2::object::UID,
        users: 0x2::table::Table<address, bool>,
    }

    struct MigrationEvent has copy, drop {
        sender: address,
        version: u64,
    }

    struct PauseEvent has copy, drop {
        sender: address,
    }

    struct UnpauseEvent has copy, drop {
        sender: address,
    }

    struct SetFeeEvent has copy, drop {
        sender: address,
        value: u64,
    }

    struct SetTimestampEvent has copy, drop {
        sender: address,
        private_open_at: u64,
        private_close_at: u64,
        public_open_at: u64,
        public_close_at: u64,
        claim_at: u64,
    }

    struct CreateLaunchpoolEvent has copy, drop {
        sender: address,
        launchpool_id: 0x2::object::ID,
        coin_type1: vector<u8>,
        coin_type2: vector<u8>,
        amount: u64,
        private_list: vector<u64>,
        public_list: vector<u64>,
        claim_at: u64,
    }

    struct PurchaseEvent has copy, drop {
        sender: address,
        launchpool_id: 0x2::object::ID,
        coin_type: vector<u8>,
        amount: u64,
    }

    struct ClaimEvent has copy, drop {
        sender: address,
        coin_type1: vector<u8>,
        coin_type2: vector<u8>,
        amount1: u64,
        amount2: u64,
        fee: u64,
    }

    public entry fun create_launchpool<T0, T1>(arg0: &0x2::clock::Clock, arg1: &mut Config, arg2: 0x2::coin::Coin<T0>, arg3: u64, arg4: vector<u64>, arg5: vector<u64>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        version_verify(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        assert!(0x1::vector::length<u64>(&arg4) == 4 && 0x1::vector::length<u64>(&arg5) == 4, 106);
        assert!(*0x1::vector::borrow<u64>(&arg4, 2) > v0 && *0x1::vector::borrow<u64>(&arg4, 3) > *0x1::vector::borrow<u64>(&arg4, 2), 107);
        assert!(*0x1::vector::borrow<u64>(&arg5, 2) > v0 && *0x1::vector::borrow<u64>(&arg5, 3) > *0x1::vector::borrow<u64>(&arg5, 2), 108);
        assert!(arg6 >= *0x1::vector::borrow<u64>(&arg5, 3), 109);
        assert!(arg3 > 0, 112);
        let v1 = refund<T0>(arg2, arg3, arg7);
        let v2 = Pool<T1>{
            balance    : 0x2::balance::zero<T1>(),
            amount     : *0x1::vector::borrow<u64>(&arg4, 0),
            max_amount : *0x1::vector::borrow<u64>(&arg4, 1),
            payments   : 0,
            open_at    : *0x1::vector::borrow<u64>(&arg4, 2),
            close_at   : *0x1::vector::borrow<u64>(&arg4, 3),
        };
        let v3 = Pool<T1>{
            balance    : 0x2::balance::zero<T1>(),
            amount     : *0x1::vector::borrow<u64>(&arg5, 0),
            max_amount : *0x1::vector::borrow<u64>(&arg5, 1),
            payments   : 0,
            open_at    : *0x1::vector::borrow<u64>(&arg5, 2),
            close_at   : *0x1::vector::borrow<u64>(&arg5, 3),
        };
        let v4 = Launchpool<T0, T1>{
            id           : 0x2::object::new(arg7),
            balance      : 0x2::coin::into_balance<T0>(v1),
            private_pool : v2,
            public_pool  : v3,
            creator      : 0x2::tx_context::sender(arg7),
            is_claimed   : false,
            amount       : arg3,
            users        : 0x2::table::new<address, UserInfo>(arg7),
            claim_at     : arg6,
        };
        let v5 = 0x2::object::id<Launchpool<T0, T1>>(&v4);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg1.pools, 0x2::table::length<u64, 0x2::object::ID>(&arg1.pools), v5);
        0x2::transfer::share_object<Launchpool<T0, T1>>(v4);
        let v6 = CreateLaunchpoolEvent{
            sender        : 0x2::tx_context::sender(arg7),
            launchpool_id : v5,
            coin_type1    : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            coin_type2    : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())),
            amount        : arg3,
            private_list  : arg4,
            public_list   : arg5,
            claim_at      : arg6,
        };
        0x2::event::emit<CreateLaunchpoolEvent>(v6);
    }

    public entry fun create_whitelist(arg0: &OwnerCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = WhiteList{
            id    : 0x2::object::new(arg1),
            users : 0x2::table::new<address, bool>(arg1),
        };
        0x2::transfer::share_object<WhiteList>(v0);
    }

    public entry fun creator_claim<T0, T1>(arg0: &0x2::clock::Clock, arg1: &Config, arg2: &mut Launchpool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg1);
        version_verify(arg1);
        assert!(arg2.creator == 0x2::tx_context::sender(arg3), 115);
        assert!(!arg2.is_claimed, 116);
        arg2.is_claimed = true;
        let v0 = 0x2::clock::timestamp_ms(arg0);
        assert!(v0 < arg2.private_pool.open_at || v0 > arg2.public_pool.close_at, 109);
        let v1 = 0;
        let v2 = 0;
        let v3 = v2;
        let v4 = if (arg2.public_pool.payments < arg2.public_pool.amount) {
            let v5 = (((arg2.amount as u128) * ((arg2.public_pool.amount - arg2.public_pool.payments) as u128) / (arg2.public_pool.amount as u128)) as u64);
            v1 = v5;
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg2.balance, v5, arg3), arg2.creator);
            if (arg1.fee_rate > 0 && arg2.public_pool.payments > 0) {
                let v6 = (((arg2.public_pool.payments as u128) * (arg1.fee_rate as u128) / (1000000000 as u128)) as u64);
                v3 = v2 + v6;
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg2.public_pool.balance, v6, arg3), arg1.owner);
            };
            let v7 = 0x2::balance::value<T1>(&arg2.public_pool.balance);
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg2.public_pool.balance, v7, arg3), arg2.creator);
            v7
        } else {
            let v8 = 0;
            if (arg1.fee_rate > 0) {
                let v9 = (((arg2.public_pool.amount as u128) * (arg1.fee_rate as u128) / (1000000000 as u128)) as u64);
                v8 = v9;
                v3 = v2 + v9;
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg2.public_pool.balance, v9, arg3), arg1.owner);
            };
            let v10 = arg2.public_pool.amount - v8;
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg2.public_pool.balance, v10, arg3), arg2.creator);
            v10
        };
        if (arg2.private_pool.payments > 0) {
            let v11 = 0;
            if (arg1.fee_rate > 0) {
                let v12 = (((arg2.private_pool.payments as u128) * (arg1.fee_rate as u128) / (1000000000 as u128)) as u64);
                v11 = v12;
                v3 = v3 + v12;
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg2.private_pool.balance, v12, arg3), arg1.owner);
            };
            let v13 = arg2.private_pool.payments - v11;
            v4 = v4 + v13;
            0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg2.private_pool.balance, v13, arg3), arg2.creator);
        };
        let v14 = ClaimEvent{
            sender     : 0x2::tx_context::sender(arg3),
            coin_type1 : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            coin_type2 : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())),
            amount1    : v1,
            amount2    : v4,
            fee        : v3,
        };
        0x2::event::emit<ClaimEvent>(v14);
    }

    public fun get_pool_id(arg0: &Config, arg1: u64) : 0x2::object::ID {
        *0x2::table::borrow<u64, 0x2::object::ID>(&arg0.pools, arg1)
    }

    public fun get_user_info<T0, T1>(arg0: &mut Launchpool<T0, T1>, arg1: address) : (u64, u64, u64, bool) {
        if (0x2::table::contains<address, UserInfo>(&arg0.users, arg1)) {
            let v4 = 0x2::table::borrow<address, UserInfo>(&arg0.users, arg1);
            let v5 = if (arg0.public_pool.payments < arg0.public_pool.amount) {
                (((arg0.amount as u128) * (v4.public_amount as u128) / (arg0.public_pool.amount as u128)) as u64)
            } else {
                (((arg0.amount as u128) * (v4.public_amount as u128) / (arg0.public_pool.payments as u128)) as u64)
            };
            (v4.private_amount, v4.public_amount, v5, v4.claimed)
        } else {
            (0, 0, 0, false)
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Config{
            id       : 0x2::object::new(arg0),
            version  : 3,
            paused   : false,
            fee_rate : 0,
            owner    : 0x2::tx_context::sender(arg0),
            pools    : 0x2::table::new<u64, 0x2::object::ID>(arg0),
        };
        0x2::transfer::share_object<Config>(v1);
    }

    public fun is_whitelist(arg0: &WhiteList, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.users, arg1)
    }

    public entry fun migration(arg0: &OwnerCap, arg1: &mut Config, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version < 3, 102);
        arg1.version = 3;
        let v0 = MigrationEvent{
            sender  : 0x2::tx_context::sender(arg2),
            version : 3,
        };
        0x2::event::emit<MigrationEvent>(v0);
    }

    public fun participants<T0, T1>(arg0: &mut Launchpool<T0, T1>) : u64 {
        0x2::table::length<address, UserInfo>(&arg0.users)
    }

    public entry fun pause(arg0: &OwnerCap, arg1: &mut Config, arg2: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg1);
        arg1.paused = true;
        let v0 = PauseEvent{sender: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<PauseEvent>(v0);
    }

    public fun paused(arg0: &Config) : bool {
        arg0.paused
    }

    public entry fun purchase<T0, T1>(arg0: &0x2::clock::Clock, arg1: &Config, arg2: &mut Launchpool<T0, T1>, arg3: 0x2::coin::Coin<T1>, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    public fun refund<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        assert!(arg1 > 0 && 0x2::coin::value<T0>(&arg0) >= arg1, 105);
        if (0x2::coin::value<T0>(&arg0) == 0) {
            0x2::coin::destroy_zero<T0>(arg0);
            return 0x2::coin::split<T0>(&mut arg0, arg1, arg2)
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg2));
        0x2::coin::split<T0>(&mut arg0, arg1, arg2)
    }

    public entry fun set_fee(arg0: &OwnerCap, arg1: &mut Config, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.fee_rate = arg2;
        let v0 = SetFeeEvent{
            sender : 0x2::tx_context::sender(arg3),
            value  : arg2,
        };
        0x2::event::emit<SetFeeEvent>(v0);
    }

    public entry fun set_timestamp<T0, T1>(arg0: &OwnerCap, arg1: &mut Launchpool<T0, T1>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        arg1.private_pool.open_at = arg2;
        arg1.private_pool.close_at = arg3;
        arg1.public_pool.open_at = arg4;
        arg1.public_pool.close_at = arg5;
        arg1.claim_at = arg6;
        let v0 = SetTimestampEvent{
            sender           : 0x2::tx_context::sender(arg7),
            private_open_at  : arg2,
            private_close_at : arg3,
            public_open_at   : arg4,
            public_close_at  : arg5,
            claim_at         : arg6,
        };
        0x2::event::emit<SetTimestampEvent>(v0);
    }

    public entry fun set_whitelist(arg0: &OwnerCap, arg1: &mut WhiteList, arg2: vector<address>, arg3: bool) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg2)) {
            if (arg3) {
                0x2::table::add<address, bool>(&mut arg1.users, *0x1::vector::borrow<address>(&arg2, v0), true);
            } else {
                0x2::table::remove<address, bool>(&mut arg1.users, *0x1::vector::borrow<address>(&arg2, v0));
            };
            v0 = v0 + 1;
        };
    }

    public entry fun unpause(arg0: &OwnerCap, arg1: &mut Config, arg2: &mut 0x2::tx_context::TxContext) {
        when_paused(arg1);
        arg1.paused = false;
        let v0 = UnpauseEvent{sender: 0x2::tx_context::sender(arg2)};
        0x2::event::emit<UnpauseEvent>(v0);
    }

    public entry fun user_claim<T0, T1>(arg0: &0x2::clock::Clock, arg1: &Config, arg2: &mut Launchpool<T0, T1>, arg3: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg1);
        version_verify(arg1);
        assert!(0x2::clock::timestamp_ms(arg0) > arg2.claim_at, 109);
        assert!(0x2::table::contains<address, UserInfo>(&arg2.users, 0x2::tx_context::sender(arg3)), 117);
        let v0 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg2.users, 0x2::tx_context::sender(arg3));
        assert!(v0.public_amount > 0, 119);
        assert!(!v0.claimed, 118);
        v0.claimed = true;
        let v1 = 0;
        let v2 = if (arg2.public_pool.payments < arg2.public_pool.amount) {
            let v3 = (((arg2.amount as u128) * (v0.public_amount as u128) / (arg2.public_pool.amount as u128)) as u64);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg2.balance, v3, arg3), 0x2::tx_context::sender(arg3));
            v3
        } else {
            let v4 = (((arg2.amount as u128) * (v0.public_amount as u128) / (arg2.public_pool.payments as u128)) as u64);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::take<T0>(&mut arg2.balance, v4, arg3), 0x2::tx_context::sender(arg3));
            let v5 = (((v0.public_amount as u128) * ((arg2.public_pool.payments - arg2.public_pool.amount) as u128) / (arg2.public_pool.payments as u128)) as u64);
            v1 = v5;
            if (v5 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::take<T1>(&mut arg2.public_pool.balance, v5, arg3), 0x2::tx_context::sender(arg3));
            };
            v4
        };
        let v6 = ClaimEvent{
            sender     : 0x2::tx_context::sender(arg3),
            coin_type1 : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T0>())),
            coin_type2 : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())),
            amount1    : v2,
            amount2    : v1,
            fee        : 0,
        };
        0x2::event::emit<ClaimEvent>(v6);
    }

    public fun version_verify(arg0: &Config) {
        assert!(arg0.version == 3, 101);
    }

    public fun when_not_paused(arg0: &Config) {
        assert!(!arg0.paused, 103);
    }

    public fun when_paused(arg0: &Config) {
        assert!(arg0.paused, 104);
    }

    public entry fun whitelist_purchase<T0, T1>(arg0: &0x2::clock::Clock, arg1: &Config, arg2: &mut Launchpool<T0, T1>, arg3: &WhiteList, arg4: 0x2::coin::Coin<T1>, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) {
        when_not_paused(arg1);
        version_verify(arg1);
        assert!(arg5 > 0, 112);
        assert!(!arg2.is_claimed, 116);
        assert!(0x2::table::contains<address, bool>(&arg3.users, 0x2::tx_context::sender(arg6)), 120);
        let v0 = 0x2::clock::timestamp_ms(arg0);
        if (v0 > arg2.private_pool.open_at && v0 < arg2.private_pool.close_at) {
            assert!(!0x2::table::contains<address, UserInfo>(&arg2.users, 0x2::tx_context::sender(arg6)), 110);
            assert!(arg2.private_pool.max_amount == arg5, 114);
            arg2.private_pool.payments = arg2.private_pool.payments + arg5;
            assert!(arg2.private_pool.amount >= arg2.private_pool.payments, 111);
            let v1 = refund<T1>(arg4, arg5, arg6);
            0x2::coin::put<T1>(&mut arg2.private_pool.balance, v1);
            let v2 = UserInfo{
                private_amount : arg5,
                public_amount  : 0,
                claimed        : false,
            };
            0x2::table::add<address, UserInfo>(&mut arg2.users, 0x2::tx_context::sender(arg6), v2);
        } else {
            assert!(v0 > arg2.public_pool.open_at && v0 < arg2.public_pool.close_at, 113);
            assert!(arg2.public_pool.max_amount == arg5, 114);
            arg2.public_pool.payments = arg2.public_pool.payments + arg5;
            assert!(arg2.public_pool.amount >= arg2.public_pool.payments, 111);
            let v3 = refund<T1>(arg4, arg5, arg6);
            0x2::coin::put<T1>(&mut arg2.public_pool.balance, v3);
            if (0x2::table::contains<address, UserInfo>(&arg2.users, 0x2::tx_context::sender(arg6))) {
                let v4 = 0x2::table::borrow_mut<address, UserInfo>(&mut arg2.users, 0x2::tx_context::sender(arg6));
                assert!(v4.public_amount == 0, 110);
                v4.public_amount = arg5;
            } else {
                let v5 = UserInfo{
                    private_amount : 0,
                    public_amount  : arg5,
                    claimed        : false,
                };
                0x2::table::add<address, UserInfo>(&mut arg2.users, 0x2::tx_context::sender(arg6), v5);
            };
        };
        let v6 = PurchaseEvent{
            sender        : 0x2::tx_context::sender(arg6),
            launchpool_id : 0x2::object::id<Launchpool<T0, T1>>(arg2),
            coin_type     : 0x1::ascii::into_bytes(0x1::type_name::into_string(0x1::type_name::get<T1>())),
            amount        : arg5,
        };
        0x2::event::emit<PurchaseEvent>(v6);
    }

    // decompiled from Move bytecode v6
}

