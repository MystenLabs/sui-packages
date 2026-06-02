module 0x8cbf4b60bff206ce8ef24f7b4a9344eec01a862d3ec206262600b3da86419cae::will {
    struct WillCreated has copy, drop {
        will_id: 0x2::object::ID,
        owner: address,
        timeout_ms: u64,
    }

    struct HeartbeatRecorded has copy, drop {
        will_id: 0x2::object::ID,
        owner: address,
        timestamp_ms: u64,
    }

    struct GraceTriggered has copy, drop {
        will_id: 0x2::object::ID,
        owner: address,
        grace_start_ms: u64,
    }

    struct GraceCancelled has copy, drop {
        will_id: 0x2::object::ID,
        owner: address,
    }

    struct WillExecuted has copy, drop {
        will_id: 0x2::object::ID,
        owner: address,
        timestamp_ms: u64,
        amount: u64,
    }

    struct FundsDeposited has copy, drop {
        will_id: 0x2::object::ID,
        owner: address,
        amount: u64,
        total_balance: u64,
    }

    struct FundsWithdrawn has copy, drop {
        will_id: 0x2::object::ID,
        owner: address,
        amount: u64,
    }

    struct SuiWill has key {
        id: 0x2::object::UID,
        owner: address,
        beneficiaries: 0x2::vec_map::VecMap<address, u64>,
        last_seen_ms: u64,
        timeout_ms: u64,
        walrus_blob_id: vector<u8>,
        in_grace: bool,
        grace_start_ms: u64,
        vault: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    public fun cancel_grace(arg0: &mut SuiWill, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        assert!(arg0.in_grace, 2);
        arg0.in_grace = false;
        arg0.grace_start_ms = 0;
        arg0.last_seen_ms = 0x2::clock::timestamp_ms(arg1);
        let v0 = GraceCancelled{
            will_id : 0x2::object::id<SuiWill>(arg0),
            owner   : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<GraceCancelled>(v0);
    }

    public fun close_will(arg0: SuiWill, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 0);
        assert!(!arg0.in_grace, 7);
        let SuiWill {
            id             : v0,
            owner          : _,
            beneficiaries  : _,
            last_seen_ms   : _,
            timeout_ms     : _,
            walrus_blob_id : _,
            in_grace       : _,
            grace_start_ms : _,
            vault          : v8,
        } = arg0;
        let v9 = v8;
        if (0x2::balance::value<0x2::sui::SUI>(&v9) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(v9, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<0x2::sui::SUI>(v9);
        };
        0x2::object::delete(v0);
    }

    public fun create_will(arg0: vector<address>, arg1: vector<u64>, arg2: u64, arg3: vector<u8>, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<address>(&arg0) == 0x1::vector::length<u64>(&arg1), 4);
        assert!(0x1::vector::length<address>(&arg0) > 0, 4);
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(&arg1)) {
            v0 = v0 + *0x1::vector::borrow<u64>(&arg1, v1);
            v1 = v1 + 1;
        };
        assert!(v0 == 10000, 4);
        let v2 = 0x2::vec_map::empty<address, u64>();
        let v3 = 0;
        while (v3 < 0x1::vector::length<address>(&arg0)) {
            0x2::vec_map::insert<address, u64>(&mut v2, *0x1::vector::borrow<address>(&arg0, v3), *0x1::vector::borrow<u64>(&arg1, v3));
            v3 = v3 + 1;
        };
        let v4 = 0x2::coin::value<0x2::sui::SUI>(&arg4);
        let v5 = SuiWill{
            id             : 0x2::object::new(arg6),
            owner          : 0x2::tx_context::sender(arg6),
            beneficiaries  : v2,
            last_seen_ms   : 0x2::clock::timestamp_ms(arg5),
            timeout_ms     : arg2,
            walrus_blob_id : arg3,
            in_grace       : false,
            grace_start_ms : 0,
            vault          : 0x2::coin::into_balance<0x2::sui::SUI>(arg4),
        };
        let v6 = WillCreated{
            will_id    : 0x2::object::id<SuiWill>(&v5),
            owner      : 0x2::tx_context::sender(arg6),
            timeout_ms : arg2,
        };
        0x2::event::emit<WillCreated>(v6);
        if (v4 > 0) {
            let v7 = FundsDeposited{
                will_id       : 0x2::object::id<SuiWill>(&v5),
                owner         : 0x2::tx_context::sender(arg6),
                amount        : v4,
                total_balance : v4,
            };
            0x2::event::emit<FundsDeposited>(v7);
        };
        0x2::transfer::share_object<SuiWill>(v5);
    }

    public fun deposit(arg0: &mut SuiWill, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        let v0 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.vault, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        let v1 = FundsDeposited{
            will_id       : 0x2::object::id<SuiWill>(arg0),
            owner         : 0x2::tx_context::sender(arg2),
            amount        : v0,
            total_balance : 0x2::balance::value<0x2::sui::SUI>(&arg0.vault) + v0,
        };
        0x2::event::emit<FundsDeposited>(v1);
    }

    public fun execute_will(arg0: &mut SuiWill, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.in_grace, 2);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.grace_start_ms + 604800000, 3);
        let v1 = 0x2::balance::value<0x2::sui::SUI>(&arg0.vault);
        assert!(v1 > 0, 6);
        let v2 = 0x2::vec_map::length<address, u64>(&arg0.beneficiaries);
        let v3 = 0;
        let v4 = 0;
        while (v3 < v2 - 1) {
            let (v5, v6) = 0x2::vec_map::get_entry_by_idx<address, u64>(&arg0.beneficiaries, v3);
            let v7 = v1 * *v6 / 10000;
            if (v7 > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v7), arg2), *v5);
                v4 = v4 + v7;
            };
            v3 = v3 + 1;
        };
        let v8 = 0x2::balance::value<0x2::sui::SUI>(&arg0.vault);
        if (v8 > 0) {
            let (v9, _) = 0x2::vec_map::get_entry_by_idx<address, u64>(&arg0.beneficiaries, v2 - 1);
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, v8), arg2), *v9);
        };
        let v11 = WillExecuted{
            will_id      : 0x2::object::id<SuiWill>(arg0),
            owner        : arg0.owner,
            timestamp_ms : v0,
            amount       : v1,
        };
        0x2::event::emit<WillExecuted>(v11);
    }

    public fun grace_start_ms(arg0: &SuiWill) : u64 {
        arg0.grace_start_ms
    }

    public fun heartbeat(arg0: &mut SuiWill, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        assert!(!arg0.in_grace, 1);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.last_seen_ms = v0;
        let v1 = HeartbeatRecorded{
            will_id      : 0x2::object::id<SuiWill>(arg0),
            owner        : 0x2::tx_context::sender(arg2),
            timestamp_ms : v0,
        };
        0x2::event::emit<HeartbeatRecorded>(v1);
    }

    public fun in_grace(arg0: &SuiWill) : bool {
        arg0.in_grace
    }

    public fun last_seen_ms(arg0: &SuiWill) : u64 {
        arg0.last_seen_ms
    }

    public fun owner(arg0: &SuiWill) : address {
        arg0.owner
    }

    public fun timeout_ms(arg0: &SuiWill) : u64 {
        arg0.timeout_ms
    }

    public fun trigger_grace(arg0: &mut SuiWill, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.in_grace, 1);
        let v0 = 0x2::clock::timestamp_ms(arg1);
        assert!(v0 >= arg0.last_seen_ms + arg0.timeout_ms, 5);
        arg0.in_grace = true;
        arg0.grace_start_ms = v0;
        let v1 = GraceTriggered{
            will_id        : 0x2::object::id<SuiWill>(arg0),
            owner          : arg0.owner,
            grace_start_ms : v0,
        };
        0x2::event::emit<GraceTriggered>(v1);
    }

    public fun update_message(arg0: &mut SuiWill, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        arg0.walrus_blob_id = arg1;
    }

    public fun vault_balance(arg0: &SuiWill) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.vault)
    }

    public fun walrus_blob_id(arg0: &SuiWill) : vector<u8> {
        arg0.walrus_blob_id
    }

    public fun withdraw(arg0: &mut SuiWill, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 0);
        assert!(!arg0.in_grace, 7);
        let v0 = FundsWithdrawn{
            will_id : 0x2::object::id<SuiWill>(arg0),
            owner   : 0x2::tx_context::sender(arg2),
            amount  : arg1,
        };
        0x2::event::emit<FundsWithdrawn>(v0);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg0.vault, arg1), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v7
}

