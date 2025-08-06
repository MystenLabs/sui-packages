module 0x1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi {
    struct ALKIMI has drop {
        dummy_field: bool,
    }

    struct ProtectedTreasury has key {
        id: 0x2::object::UID,
        current_supply: u64,
        total_burned: u64,
    }

    struct TreasuryCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct AdminRegistry has store, key {
        id: 0x2::object::UID,
        admins: vector<address>,
        max_admins: u64,
        owner: address,
        pending_owner: 0x1::option::Option<address>,
    }

    struct FunctionCallEvent has copy, drop {
        function_name: 0x1::ascii::String,
        caller: address,
        timestamp: u64,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct MintEvent has copy, drop {
        amount: u64,
        recipient: address,
        minter: address,
        total_supply_after: u64,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct BurnEvent has copy, drop {
        amount: u64,
        sender: address,
        total_supply_after: u64,
        coin_value_before: u64,
        remaining_returned: u64,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct AdminAddedEvent has copy, drop {
        admin: address,
        added_by: address,
        total_admins_after: u64,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct AdminRemovedEvent has copy, drop {
        admin: address,
        removed_by: address,
        total_admins_after: u64,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct OwnershipTransferInitiatedEvent has copy, drop {
        current_owner: address,
        pending_owner: address,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct OwnershipTransferCompletedEvent has copy, drop {
        previous_owner: address,
        new_owner: address,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    struct OwnershipTransferCancelledEvent has copy, drop {
        current_owner: address,
        cancelled_pending_owner: address,
        tx_digest: vector<u8>,
        epoch: u64,
    }

    entry fun burn(arg0: &mut ProtectedTreasury, arg1: &AdminRegistry, arg2: 0x2::coin::Coin<ALKIMI>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        emit_function_call(b"burn", v0, arg4, arg5);
        assert!(is_admin(arg1, v0) || is_owner(arg1, v0), 1000);
        assert!(arg3 > 0, 1301);
        assert!(arg3 <= arg0.current_supply, 1602);
        let v1 = 0x2::coin::value<ALKIMI>(&arg2);
        let (v2, v3) = if (v1 > arg3) {
            0x2::transfer::public_transfer<0x2::coin::Coin<ALKIMI>>(arg2, v0);
            (0x2::coin::split<ALKIMI>(&mut arg2, arg3, arg5), v1 - arg3)
        } else {
            assert!(v1 == arg3, 1302);
            (arg2, 0)
        };
        let v4 = arg0.current_supply;
        arg0.current_supply = v4 - arg3;
        arg0.total_burned = safe_add_burned(arg0.total_burned, arg3);
        let v5 = BurnEvent{
            amount             : arg3,
            sender             : v0,
            total_supply_after : v4 - arg3,
            coin_value_before  : v1,
            remaining_returned : v3,
            tx_digest          : *0x2::tx_context::digest(arg5),
            epoch              : 0x2::tx_context::epoch(arg5),
        };
        0x2::event::emit<BurnEvent>(v5);
        let v6 = borrow_cap_mut(arg0);
        0x2::coin::burn<ALKIMI>(v6, v2);
        assert!(arg0.current_supply == 0x2::coin::total_supply<ALKIMI>(borrow_cap(arg0)), 1404);
    }

    entry fun total_supply(arg0: &ProtectedTreasury) : u64 {
        0x2::coin::total_supply<ALKIMI>(borrow_cap(arg0))
    }

    entry fun make_immutable(arg0: 0x2::package::UpgradeCap, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        emit_function_call(b"make_immutable", 0x2::tx_context::sender(arg2), arg1, arg2);
        0x2::package::make_immutable(arg0);
    }

    entry fun accept_ownership(arg0: &mut AdminRegistry, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        emit_function_call(b"accept_ownership", v0, arg1, arg2);
        assert!(0x1::option::is_some<address>(&arg0.pending_owner), 1500);
        assert!(v0 == *0x1::option::borrow<address>(&arg0.pending_owner), 1501);
        assert!(!is_admin(arg0, v0), 1103);
        arg0.owner = v0;
        arg0.pending_owner = 0x1::option::none<address>();
        let v1 = OwnershipTransferCompletedEvent{
            previous_owner : arg0.owner,
            new_owner      : v0,
            tx_digest      : *0x2::tx_context::digest(arg2),
            epoch          : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<OwnershipTransferCompletedEvent>(v1);
    }

    entry fun add_admin(arg0: &mut AdminRegistry, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        emit_function_call(b"add_admin", v0, arg2, arg3);
        assert!(is_owner(arg0, v0), 1001);
        assert!(arg1 != @0x0, 1300);
        assert!(!is_admin(arg0, arg1), 1100);
        assert!(arg1 != arg0.owner, 1104);
        if (0x1::option::is_some<address>(&arg0.pending_owner)) {
            assert!(arg1 != *0x1::option::borrow<address>(&arg0.pending_owner), 1103);
        };
        assert!(0x1::vector::length<address>(&arg0.admins) < arg0.max_admins, 1102);
        0x1::vector::push_back<address>(&mut arg0.admins, arg1);
        let v1 = AdminAddedEvent{
            admin              : arg1,
            added_by           : v0,
            total_admins_after : 0x1::vector::length<address>(&arg0.admins),
            tx_digest          : *0x2::tx_context::digest(arg3),
            epoch              : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<AdminAddedEvent>(v1);
    }

    fun borrow_cap(arg0: &ProtectedTreasury) : &0x2::coin::TreasuryCap<ALKIMI> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<TreasuryCapKey, 0x2::coin::TreasuryCap<ALKIMI>>(&arg0.id, v0)
    }

    fun borrow_cap_mut(arg0: &mut ProtectedTreasury) : &mut 0x2::coin::TreasuryCap<ALKIMI> {
        let v0 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<TreasuryCapKey, 0x2::coin::TreasuryCap<ALKIMI>>(&mut arg0.id, v0)
    }

    entry fun cancel_ownership_transfer(arg0: &mut AdminRegistry, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        emit_function_call(b"cancel_ownership_transfer", v0, arg1, arg2);
        assert!(is_owner(arg0, v0), 1001);
        assert!(0x1::option::is_some<address>(&arg0.pending_owner), 1500);
        arg0.pending_owner = 0x1::option::none<address>();
        let v1 = OwnershipTransferCancelledEvent{
            current_owner           : v0,
            cancelled_pending_owner : *0x1::option::borrow<address>(&arg0.pending_owner),
            tx_digest               : *0x2::tx_context::digest(arg2),
            epoch                   : 0x2::tx_context::epoch(arg2),
        };
        0x2::event::emit<OwnershipTransferCancelledEvent>(v1);
    }

    fun emit_function_call(arg0: vector<u8>, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = FunctionCallEvent{
            function_name : 0x1::ascii::string(arg0),
            caller        : arg1,
            timestamp     : 0x2::clock::timestamp_ms(arg2),
            tx_digest     : *0x2::tx_context::digest(arg3),
            epoch         : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<FunctionCallEvent>(v0);
    }

    entry fun get_admins(arg0: &AdminRegistry) : vector<address> {
        arg0.admins
    }

    entry fun get_current_supply(arg0: &ProtectedTreasury) : u64 {
        assert!(arg0.current_supply == 0x2::coin::total_supply<ALKIMI>(borrow_cap(arg0)), 1404);
        arg0.current_supply
    }

    entry fun get_owner(arg0: &AdminRegistry) : address {
        arg0.owner
    }

    entry fun get_pending_owner(arg0: &AdminRegistry) : 0x1::option::Option<address> {
        arg0.pending_owner
    }

    entry fun get_total_burned(arg0: &ProtectedTreasury) : u64 {
        arg0.total_burned
    }

    entry fun has_pending_ownership(arg0: &AdminRegistry) : bool {
        0x1::option::is_some<address>(&arg0.pending_owner)
    }

    fun init(arg0: ALKIMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALKIMI>(arg0, 9, b"ALKIMI", b"Alkimi", b"Alkimi bridges traditional advertising with DeFi (AdFi), creating a decentralised protocol where digital ad spend becomes a yield-generating asset. Built for enterprise scale on Sui, ALKIMI rewards holders through protocol fees, staking, and liquidity provision.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.alkimi.org/images/img1_circle.png"))), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        let v3 = AdminRegistry{
            id            : 0x2::object::new(arg1),
            admins        : 0x1::vector::empty<address>(),
            max_admins    : 2,
            owner         : v2,
            pending_owner : 0x1::option::none<address>(),
        };
        let v4 = ProtectedTreasury{
            id             : 0x2::object::new(arg1),
            current_supply : 0,
            total_burned   : 0,
        };
        let v5 = TreasuryCapKey{dummy_field: false};
        0x2::dynamic_object_field::add<TreasuryCapKey, 0x2::coin::TreasuryCap<ALKIMI>>(&mut v4.id, v5, v0);
        let v6 = &mut v4;
        v4.current_supply = 1000000000000000000;
        let v7 = MintEvent{
            amount             : 1000000000000000000,
            recipient          : @0x55af3b88002574288e6ca17994e3ab39b375091ba229939e3d056b3a7858165,
            minter             : v2,
            total_supply_after : 1000000000000000000,
            tx_digest          : *0x2::tx_context::digest(arg1),
            epoch              : 0x2::tx_context::epoch(arg1),
        };
        0x2::event::emit<MintEvent>(v7);
        0x2::transfer::public_transfer<0x2::coin::Coin<ALKIMI>>(0x2::coin::mint<ALKIMI>(borrow_cap_mut(v6), 1000000000000000000, arg1), @0x55af3b88002574288e6ca17994e3ab39b375091ba229939e3d056b3a7858165);
        0x2::transfer::share_object<ProtectedTreasury>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALKIMI>>(v1);
        0x2::transfer::share_object<AdminRegistry>(v3);
    }

    fun is_admin(arg0: &AdminRegistry, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(&arg0.admins)) {
            if (*0x1::vector::borrow<address>(&arg0.admins, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun is_owner(arg0: &AdminRegistry, arg1: address) : bool {
        arg0.owner == arg1
    }

    entry fun remove_admin(arg0: &mut AdminRegistry, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        emit_function_call(b"remove_admin", v0, arg2, arg3);
        assert!(is_owner(arg0, v0), 1001);
        assert!(is_admin(arg0, arg1), 1101);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0.admins)) {
            if (*0x1::vector::borrow<address>(&arg0.admins, v1) == arg1) {
                0x1::vector::remove<address>(&mut arg0.admins, v1);
                break
            };
            v1 = v1 + 1;
        };
        let v2 = AdminRemovedEvent{
            admin              : arg1,
            removed_by         : v0,
            total_admins_after : 0x1::vector::length<address>(&arg0.admins),
            tx_digest          : *0x2::tx_context::digest(arg3),
            epoch              : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<AdminRemovedEvent>(v2);
    }

    fun safe_add_burned(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 18446744073709551615 - arg1, 1601);
        arg0 + arg1
    }

    entry fun transfer_ownership(arg0: &mut AdminRegistry, arg1: address, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        emit_function_call(b"transfer_ownership", v0, arg2, arg3);
        assert!(is_owner(arg0, v0), 1002);
        assert!(arg1 != @0x0, 1300);
        assert!(arg1 != v0, 1200);
        assert!(!is_admin(arg0, arg1), 1103);
        assert!(0x1::option::is_none<address>(&arg0.pending_owner), 1502);
        arg0.pending_owner = 0x1::option::some<address>(arg1);
        let v1 = OwnershipTransferInitiatedEvent{
            current_owner : v0,
            pending_owner : arg1,
            tx_digest     : *0x2::tx_context::digest(arg3),
            epoch         : 0x2::tx_context::epoch(arg3),
        };
        0x2::event::emit<OwnershipTransferInitiatedEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

