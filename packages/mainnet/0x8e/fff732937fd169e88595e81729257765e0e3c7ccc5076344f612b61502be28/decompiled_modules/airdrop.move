module 0x8efff732937fd169e88595e81729257765e0e3c7ccc5076344f612b61502be28::airdrop {
    struct AIRDROP has drop {
        dummy_field: bool,
    }

    struct EventStop has copy, drop, store {
        airdrop: 0x2::object::ID,
        at: u64,
    }

    struct EventUnstop has copy, drop, store {
        airdrop: 0x2::object::ID,
        at: u64,
        new_end: u64,
    }

    struct EventDeposit has copy, drop, store {
        airdrop: 0x2::object::ID,
        delta: u64,
        balance: u64,
    }

    struct EventWithdraw has copy, drop, store {
        airdrop: 0x2::object::ID,
        delta: u64,
        balance: u64,
    }

    struct EventUpdateStart has copy, drop, store {
        airdrop: 0x2::object::ID,
        old_start: u64,
        new_start: u64,
    }

    struct EventUpdateEnd has copy, drop, store {
        airdrop: 0x2::object::ID,
        old_end: u64,
        new_end: u64,
    }

    struct EventUpdateRoot has copy, drop, store {
        airdrop: 0x2::object::ID,
        old_root: vector<u8>,
        new_root: vector<u8>,
    }

    struct EventClaim has copy, drop, store {
        airdrop: 0x2::object::ID,
        who: address,
        amount: u64,
        time: u64,
    }

    struct Airdrop<phantom T0> has store, key {
        id: 0x2::object::UID,
        coin_type: 0x1::type_name::TypeName,
        balance: 0x2::balance::Balance<T0>,
        merkle_root: vector<u8>,
        start_from: u64,
        end: u64,
        stopped: bool,
        claimed_users: 0x2::table::Table<address, u64>,
    }

    public fun claim<T0>(arg0: &mut Airdrop<T0>, arg1: u64, arg2: vector<vector<u8>>, arg3: vector<bool>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(!arg0.stopped, 6);
        assert!(0x1::vector::length<vector<u8>>(&arg2) == 0x1::vector::length<bool>(&arg3), 13906835029041872895);
        let v0 = now(arg4);
        assert!(v0 >= arg0.start_from, 1);
        assert!(v0 < arg0.end, 2);
        assert!(!0x2::table::contains<address, u64>(&arg0.claimed_users, 0x2::tx_context::sender(arg5)), 3);
        assert!(verify(arg0.merkle_root, generate_merkle_leaf(0x2::tx_context::sender(arg5), arg1), arg2, arg3), 4);
        0x2::table::add<address, u64>(&mut arg0.claimed_users, 0x2::tx_context::sender(arg5), arg1);
        let v1 = EventClaim{
            airdrop : 0x2::object::id<Airdrop<T0>>(arg0),
            who     : 0x2::tx_context::sender(arg5),
            amount  : arg1,
            time    : v0,
        };
        0x2::event::emit<EventClaim>(v1);
        0x2::balance::split<T0>(&mut arg0.balance, arg1)
    }

    entry fun claim_ex<T0>(arg0: &mut Airdrop<T0>, arg1: u64, arg2: vector<vector<u8>>, arg3: vector<bool>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = claim<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v0, arg5), 0x2::tx_context::sender(arg5));
    }

    public fun deposit<T0>(arg0: &mut Airdrop<T0>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.stopped, 6);
        let v0 = 0x2::balance::value<T0>(&arg1);
        assert!(v0 > 0, 13906834612430045183);
        let v1 = EventDeposit{
            airdrop : 0x2::object::id<Airdrop<T0>>(arg0),
            delta   : v0,
            balance : 0x2::balance::join<T0>(&mut arg0.balance, arg1),
        };
        0x2::event::emit<EventDeposit>(v1);
    }

    public fun generate_merkle_leaf(arg0: address, arg1: u64) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<address>(&arg0);
        0x1::vector::append<u8>(&mut v0, 0x2::bcs::to_bytes<u64>(&arg1));
        0x2::hash::blake2b256(&v0)
    }

    fun init(arg0: AIRDROP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<AIRDROP>(arg0, arg1);
    }

    public fun now(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0) / 1000
    }

    public fun setup<T0>(arg0: &0x2::package::Publisher, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<Airdrop<T0>>(arg0), 13906834539415601151);
        let v0 = Airdrop<T0>{
            id            : 0x2::object::new(arg1),
            coin_type     : 0x1::type_name::with_defining_ids<T0>(),
            balance       : 0x2::balance::zero<T0>(),
            merkle_root   : 0x1::vector::empty<u8>(),
            start_from    : 0,
            end           : 0,
            stopped       : false,
            claimed_users : 0x2::table::new<address, u64>(arg1),
        };
        0x2::transfer::share_object<Airdrop<T0>>(v0);
    }

    public fun stop<T0>(arg0: &0x2::package::Publisher, arg1: &mut Airdrop<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<AIRDROP>(arg0), 13906835200840564735);
        assert!(!arg1.stopped, 6);
        arg1.end = now(arg2);
        arg1.stopped = true;
        let v0 = EventStop{
            airdrop : 0x2::object::id<Airdrop<T0>>(arg1),
            at      : arg1.end,
        };
        0x2::event::emit<EventStop>(v0);
    }

    public fun unstop<T0>(arg0: &0x2::package::Publisher, arg1: &mut Airdrop<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.stopped, 6);
        assert!(0x2::package::from_module<AIRDROP>(arg0), 13906835239495270399);
        assert!(arg2 > arg1.end, 13906835243790237695);
        arg1.end = arg2;
        arg1.stopped = false;
        let v0 = EventUnstop{
            airdrop : 0x2::object::id<Airdrop<T0>>(arg1),
            at      : now(arg3),
            new_end : arg2,
        };
        0x2::event::emit<EventUnstop>(v0);
    }

    public fun update_end<T0>(arg0: &0x2::package::Publisher, arg1: &mut Airdrop<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<Airdrop<T0>>(arg0), 13906834865833115647);
        assert!(arg1.end == 0 || now(arg3) < arg1.start_from, 13906834870128082943);
        arg1.end = arg2;
        let v0 = EventUpdateEnd{
            airdrop : 0x2::object::id<Airdrop<T0>>(arg1),
            old_end : arg1.end,
            new_end : arg2,
        };
        0x2::event::emit<EventUpdateEnd>(v0);
    }

    public fun update_root<T0>(arg0: &0x2::package::Publisher, arg1: &mut Airdrop<T0>, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<Airdrop<T0>>(arg0), 13906834943142526975);
        assert!(arg1.start_from == 0 || now(arg3) < arg1.start_from, 13906834947437494271);
        arg1.merkle_root = arg2;
        let v0 = EventUpdateRoot{
            airdrop  : 0x2::object::id<Airdrop<T0>>(arg1),
            old_root : arg1.merkle_root,
            new_root : arg2,
        };
        0x2::event::emit<EventUpdateRoot>(v0);
    }

    public fun update_start<T0>(arg0: &0x2::package::Publisher, arg1: &mut Airdrop<T0>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::package::from_module<Airdrop<T0>>(arg0), 13906834788523704319);
        assert!(arg1.start_from == 0 || now(arg3) < arg1.start_from, 13906834792818671615);
        arg1.start_from = arg2;
        let v0 = EventUpdateStart{
            airdrop   : 0x2::object::id<Airdrop<T0>>(arg1),
            old_start : arg1.start_from,
            new_start : arg2,
        };
        0x2::event::emit<EventUpdateStart>(v0);
    }

    public fun verify(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<vector<u8>>, arg3: vector<bool>) : bool {
        if (0x1::vector::length<vector<u8>>(&arg2) != 0x1::vector::length<bool>(&arg3)) {
            return false
        };
        let v0 = 0x1::vector::empty<u8>();
        0x1::vector::append<u8>(&mut v0, arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<vector<u8>>(&arg2)) {
            let v2 = 0x1::vector::empty<u8>();
            let v3 = if (*0x1::vector::borrow<bool>(&arg3, v1)) {
                0x1::vector::append<u8>(&mut v2, v0);
                0x1::vector::append<u8>(&mut v2, *0x1::vector::borrow<vector<u8>>(&arg2, v1));
                0x2::hash::blake2b256(&v2)
            } else {
                0x1::vector::append<u8>(&mut v2, *0x1::vector::borrow<vector<u8>>(&arg2, v1));
                0x1::vector::append<u8>(&mut v2, v0);
                0x2::hash::blake2b256(&v2)
            };
            v0 = v3;
            v1 = v1 + 1;
        };
        if (0x1::vector::length<u8>(&v0) != 0x1::vector::length<u8>(&arg0)) {
            return false
        };
        v1 = 0;
        while (v1 < 0x1::vector::length<u8>(&v0)) {
            if (*0x1::vector::borrow<u8>(&v0, v1) != *0x1::vector::borrow<u8>(&arg0, v1)) {
                return false
            };
            v1 = v1 + 1;
        };
        true
    }

    public fun withdraw<T0>(arg0: &0x2::package::Publisher, arg1: &mut Airdrop<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        assert!(0x2::package::from_module<Airdrop<T0>>(arg0), 13906834698329391103);
        assert!(now(arg2) >= arg1.end, 5);
        let v0 = 0x2::balance::withdraw_all<T0>(&mut arg1.balance);
        let v1 = EventWithdraw{
            airdrop : 0x2::object::id<Airdrop<T0>>(arg1),
            delta   : 0x2::balance::value<T0>(&v0),
            balance : 0x2::balance::value<T0>(&arg1.balance),
        };
        0x2::event::emit<EventWithdraw>(v1);
        v0
    }

    // decompiled from Move bytecode v6
}

