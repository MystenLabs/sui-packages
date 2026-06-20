module 0xcc7e825315cdad1630eb1e3073fd91005770737bfefd40746aba66835265f766::inheritance {
    struct Inheritance has key {
        id: 0x2::object::UID,
        walletID: 0x2::object::ID,
        owner: address,
        last_update: u64,
        time_left: u64,
        is_warned: bool,
        cap_percentage: 0x2::vec_map::VecMap<u8, u8>,
        cap_activated: 0x2::vec_map::VecMap<u8, bool>,
        next_cap_id: u8,
        total_percentage: u16,
        asset_withdrawn: 0x2::table::Table<0x1::type_name::TypeName, vector<u8>>,
    }

    struct InheritanceService has drop {
        dummy_field: bool,
    }

    struct MemberCap has store, key {
        id: 0x2::object::UID,
        walletID: 0x2::object::ID,
        inheritanceID: 0x2::object::ID,
        capID: u8,
    }

    struct HashlockInvite has key {
        id: 0x2::object::UID,
        walletID: 0x2::object::ID,
        inheritanceID: 0x2::object::ID,
        capID: u8,
        label_hash: vector<u8>,
        preimage_hash: vector<u8>,
        member_cap: 0x1::option::Option<MemberCap>,
    }

    struct RemainingPercentageKey has copy, drop, store {
        coin: 0x1::type_name::TypeName,
    }

    struct WithdrawnKey has copy, drop, store {
        coin: 0x1::type_name::TypeName,
        cap_id: u8,
    }

    struct InheritanceCreated has copy, drop {
        inheritance_id: 0x2::object::ID,
        wallet_id: 0x2::object::ID,
        owner: address,
        created_at_ms: u64,
    }

    struct MemberAdded has copy, drop {
        inheritance_id: 0x2::object::ID,
        cap_id: u8,
        member: address,
        percentage: u8,
    }

    struct MemberRemoved has copy, drop {
        inheritance_id: 0x2::object::ID,
        cap_id: u8,
    }

    struct MemberCapModified has copy, drop {
        inheritance_id: 0x2::object::ID,
        cap_id: u8,
        percentage: u8,
        activated: bool,
    }

    struct TimeUpdated has copy, drop {
        inheritance_id: 0x2::object::ID,
        last_update_ms: u64,
        is_warned: bool,
    }

    struct GraceStarted has copy, drop {
        inheritance_id: 0x2::object::ID,
        started_at_ms: u64,
        grace_period_ms: u64,
        triggered_by_cap_id: u8,
    }

    struct MemberWithdrew has copy, drop {
        inheritance_id: 0x2::object::ID,
        cap_id: u8,
        coin: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct ZkSendInviteCreated has copy, drop {
        inheritance_id: 0x2::object::ID,
        wallet_id: 0x2::object::ID,
        cap_id: u8,
        label_hash: vector<u8>,
        percentage: u8,
    }

    struct HashlockInviteCreated has copy, drop {
        invite_id: 0x2::object::ID,
        inheritance_id: 0x2::object::ID,
        wallet_id: 0x2::object::ID,
        cap_id: u8,
        label_hash: vector<u8>,
        preimage_hash: vector<u8>,
        percentage: u8,
    }

    struct HashlockInviteClaimed has copy, drop {
        invite_id: 0x2::object::ID,
        inheritance_id: 0x2::object::ID,
        cap_id: u8,
        recipient: address,
    }

    public fun add_member_by_addresses(arg0: &mut Inheritance, arg1: vector<address>, arg2: vector<u8>, arg3: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg3);
        assert_mutable(arg0);
        assert!(0x1::vector::length<address>(&arg1) == 0x1::vector::length<u8>(&arg2), 7);
        let v0 = 0x2::object::id<Inheritance>(arg0);
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg1)) {
            let v2 = *0x1::vector::borrow<u8>(&arg2, v1);
            let (v3, v4) = register_member(arg0, v0, v2, arg3);
            0x2::transfer::public_transfer<MemberCap>(v4, *0x1::vector::borrow<address>(&arg1, v1));
            let v5 = MemberAdded{
                inheritance_id : v0,
                cap_id         : v3,
                member         : *0x1::vector::borrow<address>(&arg1, v1),
                percentage     : v2,
            };
            0x2::event::emit<MemberAdded>(v5);
            v1 = v1 + 1;
        };
    }

    public fun add_member_by_email(arg0: &mut Inheritance, arg1: 0x1::string::String, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : MemberCap {
        assert_owner(arg0, arg3);
        assert_mutable(arg0);
        let v0 = 0x2::object::id<Inheritance>(arg0);
        let (v1, v2) = register_member(arg0, v0, arg2, arg3);
        let v3 = MemberAdded{
            inheritance_id : v0,
            cap_id         : v1,
            member         : @0x0,
            percentage     : arg2,
        };
        0x2::event::emit<MemberAdded>(v3);
        v2
    }

    public fun add_member_by_hashlock(arg0: &mut Inheritance, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg4);
        assert_mutable(arg0);
        assert_hash_32(&arg2);
        let v0 = 0x2::object::id<Inheritance>(arg0);
        let (v1, v2) = register_member(arg0, v0, arg3, arg4);
        let v3 = HashlockInvite{
            id            : 0x2::object::new(arg4),
            walletID      : arg0.walletID,
            inheritanceID : v0,
            capID         : v1,
            label_hash    : arg1,
            preimage_hash : arg2,
            member_cap    : 0x1::option::some<MemberCap>(v2),
        };
        0x2::transfer::share_object<HashlockInvite>(v3);
        let v4 = MemberAdded{
            inheritance_id : v0,
            cap_id         : v1,
            member         : @0x0,
            percentage     : arg3,
        };
        0x2::event::emit<MemberAdded>(v4);
        let v5 = HashlockInviteCreated{
            invite_id      : 0x2::object::id<HashlockInvite>(&v3),
            inheritance_id : v0,
            wallet_id      : arg0.walletID,
            cap_id         : v1,
            label_hash     : arg1,
            preimage_hash  : arg2,
            percentage     : arg3,
        };
        0x2::event::emit<HashlockInviteCreated>(v5);
    }

    public fun add_member_for_zksend(arg0: &mut Inheritance, arg1: vector<u8>, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : MemberCap {
        assert_owner(arg0, arg3);
        assert_mutable(arg0);
        let v0 = 0x2::object::id<Inheritance>(arg0);
        let (v1, v2) = register_member(arg0, v0, arg2, arg3);
        let v3 = MemberAdded{
            inheritance_id : v0,
            cap_id         : v1,
            member         : @0x0,
            percentage     : arg2,
        };
        0x2::event::emit<MemberAdded>(v3);
        let v4 = ZkSendInviteCreated{
            inheritance_id : v0,
            wallet_id      : arg0.walletID,
            cap_id         : v1,
            label_hash     : arg1,
            percentage     : arg2,
        };
        0x2::event::emit<ZkSendInviteCreated>(v4);
        v2
    }

    fun assert_hash_32(arg0: &vector<u8>) {
        assert!(0x1::vector::length<u8>(arg0) == 32, 17);
    }

    fun assert_mutable(arg0: &Inheritance) {
        assert!(!arg0.is_warned, 12);
    }

    fun assert_owner(arg0: &Inheritance, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.owner, 11);
    }

    fun assert_total_percentage_complete(arg0: &Inheritance) {
        assert!(arg0.total_percentage == 100, 9);
    }

    fun assert_valid_member_cap(arg0: &MemberCap, arg1: &Inheritance, arg2: 0x2::object::ID) {
        assert!(arg0.walletID == arg2, 0);
        assert!(arg0.inheritanceID == 0x2::object::id<Inheritance>(arg1), 1);
        assert!(arg1.walletID == arg2, 0);
        assert!(0x2::vec_map::contains<u8, u8>(&arg1.cap_percentage, &arg0.capID), 2);
        assert!(*0x2::vec_map::get<u8, bool>(&arg1.cap_activated, &arg0.capID), 6);
    }

    public fun claim_hashlock_member(arg0: &mut HashlockInvite, arg1: vector<u8>, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::option::is_some<MemberCap>(&arg0.member_cap), 15);
        assert!(0x1::hash::sha2_256(arg1) == arg0.preimage_hash, 16);
        let v0 = 0x2::tx_context::sender(arg2);
        0x2::transfer::public_transfer<MemberCap>(0x1::option::extract<MemberCap>(&mut arg0.member_cap), v0);
        let v1 = HashlockInviteClaimed{
            invite_id      : 0x2::object::id<HashlockInvite>(arg0),
            inheritance_id : arg0.inheritanceID,
            cap_id         : arg0.capID,
            recipient      : v0,
        };
        0x2::event::emit<HashlockInviteClaimed>(v1);
    }

    public fun create_inheritance(arg0: &0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg0);
        let v1 = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::owner(arg0);
        assert!(0x2::tx_context::sender(arg2) == v1, 0);
        let v2 = 0x2::clock::timestamp_ms(arg1);
        let v3 = Inheritance{
            id               : 0x2::object::new(arg2),
            walletID         : v0,
            owner            : v1,
            last_update      : v2,
            time_left        : 15552000000,
            is_warned        : false,
            cap_percentage   : 0x2::vec_map::empty<u8, u8>(),
            cap_activated    : 0x2::vec_map::empty<u8, bool>(),
            next_cap_id      : 0,
            total_percentage : 0,
            asset_withdrawn  : 0x2::table::new<0x1::type_name::TypeName, vector<u8>>(arg2),
        };
        0x2::transfer::share_object<Inheritance>(v3);
        let v4 = InheritanceCreated{
            inheritance_id : 0x2::object::id<Inheritance>(&v3),
            wallet_id      : v0,
            owner          : v1,
            created_at_ms  : v2,
        };
        0x2::event::emit<InheritanceCreated>(v4);
    }

    fun mark_withdrawn(arg0: &mut Inheritance, arg1: 0x1::type_name::TypeName, arg2: u8) {
        let v0 = WithdrawnKey{
            coin   : arg1,
            cap_id : arg2,
        };
        assert!(!0x2::dynamic_field::exists<WithdrawnKey>(&arg0.id, v0), 5);
        if (0x2::table::contains<0x1::type_name::TypeName, vector<u8>>(&arg0.asset_withdrawn, arg1)) {
            assert!(!0x1::vector::contains<u8>(0x2::table::borrow<0x1::type_name::TypeName, vector<u8>>(&arg0.asset_withdrawn, arg1), &arg2), 5);
        };
        0x2::dynamic_field::add<WithdrawnKey, bool>(&mut arg0.id, v0, true);
    }

    public fun member_withdraw<T0>(arg0: &MemberCap, arg1: &mut Inheritance, arg2: &mut 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::Wallet, arg3: &0x2::accumulator::AccumulatorRoot, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert_valid_member_cap(arg0, arg1, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::id(arg2));
        assert_total_percentage_complete(arg1);
        assert!(0x2::clock::timestamp_ms(arg4) - arg1.last_update >= arg1.time_left, 4);
        if (!arg1.is_warned) {
            start_grace_period(arg1, arg4, arg0.capID);
            return
        };
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        let v1 = withdraw_amount_for_cap(arg1, v0, arg0.capID, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::wallet::balance<T0>(arg2, arg3));
        let v2 = 0x2::tx_context::sender(arg5);
        let v3 = InheritanceService{dummy_field: false};
        let (v4, v5) = 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::validate_and_pay_unmetered<InheritanceService, T0>(arg2, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::request_payment_unmetered<InheritanceService, T0>(v3, v1, v2), arg5);
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v4, v2);
        let v6 = InheritanceService{dummy_field: false};
        0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::verify_and_clear<InheritanceService, T0>(v5, 0xcd4064c00cc557738decf0a7714359fcf8197e72d0b0bd2c1a39b75f726435df::intent::create_receipt_sig<InheritanceService, T0>(v6, v1, v2));
        let v7 = MemberWithdrew{
            inheritance_id : 0x2::object::id<Inheritance>(arg1),
            cap_id         : arg0.capID,
            coin           : v0,
            amount         : v1,
        };
        0x2::event::emit<MemberWithdrew>(v7);
    }

    public fun modify_member_cap(arg0: &mut Inheritance, arg1: u8, arg2: u8, arg3: bool, arg4: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg4);
        assert_mutable(arg0);
        assert!(0x2::vec_map::contains<u8, u8>(&arg0.cap_percentage, &arg1), 2);
        if (*0x2::vec_map::get<u8, bool>(&arg0.cap_activated, &arg1)) {
            arg0.total_percentage = arg0.total_percentage - (*0x2::vec_map::get<u8, u8>(&arg0.cap_percentage, &arg1) as u16);
        };
        if (arg3) {
            arg0.total_percentage = arg0.total_percentage + (arg2 as u16);
        };
        assert!(arg0.total_percentage <= 100, 3);
        *0x2::vec_map::get_mut<u8, u8>(&mut arg0.cap_percentage, &arg1) = arg2;
        *0x2::vec_map::get_mut<u8, bool>(&mut arg0.cap_activated, &arg1) = arg3;
        let v0 = MemberCapModified{
            inheritance_id : 0x2::object::id<Inheritance>(arg0),
            cap_id         : arg1,
            percentage     : arg2,
            activated      : arg3,
        };
        0x2::event::emit<MemberCapModified>(v0);
    }

    fun register_member(arg0: &mut Inheritance, arg1: 0x2::object::ID, arg2: u8, arg3: &mut 0x2::tx_context::TxContext) : (u8, MemberCap) {
        arg0.total_percentage = arg0.total_percentage + (arg2 as u16);
        assert!(arg0.total_percentage <= 100, 3);
        assert!(arg0.next_cap_id < 255, 10);
        let v0 = arg0.next_cap_id;
        let v1 = MemberCap{
            id            : 0x2::object::new(arg3),
            walletID      : arg0.walletID,
            inheritanceID : arg1,
            capID         : v0,
        };
        0x2::vec_map::insert<u8, u8>(&mut arg0.cap_percentage, v0, arg2);
        0x2::vec_map::insert<u8, bool>(&mut arg0.cap_activated, v0, true);
        arg0.next_cap_id = v0 + 1;
        (v0, v1)
    }

    public fun remove_member(arg0: &mut Inheritance, arg1: u8, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        assert_mutable(arg0);
        assert!(0x2::vec_map::contains<u8, u8>(&arg0.cap_percentage, &arg1), 2);
        let (_, v1) = 0x2::vec_map::remove<u8, u8>(&mut arg0.cap_percentage, &arg1);
        let (_, v3) = 0x2::vec_map::remove<u8, bool>(&mut arg0.cap_activated, &arg1);
        if (v3) {
            arg0.total_percentage = arg0.total_percentage - (v1 as u16);
        };
        let v4 = MemberRemoved{
            inheritance_id : 0x2::object::id<Inheritance>(arg0),
            cap_id         : arg1,
        };
        0x2::event::emit<MemberRemoved>(v4);
    }

    fun start_grace_period(arg0: &mut Inheritance, arg1: &0x2::clock::Clock, arg2: u8) {
        let v0 = 0x2::clock::timestamp_ms(arg1);
        arg0.last_update = v0;
        arg0.time_left = 604800000;
        arg0.is_warned = true;
        let v1 = GraceStarted{
            inheritance_id      : 0x2::object::id<Inheritance>(arg0),
            started_at_ms       : v0,
            grace_period_ms     : 604800000,
            triggered_by_cap_id : arg2,
        };
        0x2::event::emit<GraceStarted>(v1);
    }

    public fun update_time(arg0: &mut Inheritance, arg1: &0x2::clock::Clock, arg2: &0x2::tx_context::TxContext) {
        assert_owner(arg0, arg2);
        arg0.last_update = 0x2::clock::timestamp_ms(arg1);
        if (arg0.is_warned) {
            arg0.time_left = 15552000000;
            arg0.is_warned = false;
        };
        let v0 = TimeUpdated{
            inheritance_id : 0x2::object::id<Inheritance>(arg0),
            last_update_ms : arg0.last_update,
            is_warned      : arg0.is_warned,
        };
        0x2::event::emit<TimeUpdated>(v0);
    }

    fun withdraw_amount_by_remaining_percentage(arg0: &mut Inheritance, arg1: 0x1::type_name::TypeName, arg2: u64, arg3: u64) : u64 {
        if (arg3 == 0) {
            return 0
        };
        let v0 = RemainingPercentageKey{coin: arg1};
        if (!0x2::dynamic_field::exists<RemainingPercentageKey>(&arg0.id, v0)) {
            0x2::dynamic_field::add<RemainingPercentageKey, u16>(&mut arg0.id, v0, arg0.total_percentage);
        };
        let v1 = 0x2::dynamic_field::borrow_mut<RemainingPercentageKey, u16>(&mut arg0.id, v0);
        let v2 = (arg3 as u16);
        assert!(*v1 > 0, 13);
        assert!(*v1 >= v2, 14);
        let v3 = if (*v1 == v2) {
            arg2
        } else {
            arg2 * arg3 / (*v1 as u64)
        };
        *v1 = *v1 - v2;
        v3
    }

    fun withdraw_amount_for_cap(arg0: &mut Inheritance, arg1: 0x1::type_name::TypeName, arg2: u8, arg3: u64) : u64 {
        mark_withdrawn(arg0, arg1, arg2);
        let v0 = (*0x2::vec_map::get<u8, u8>(&arg0.cap_percentage, &arg2) as u64);
        withdraw_amount_by_remaining_percentage(arg0, arg1, arg3, v0)
    }

    // decompiled from Move bytecode v7
}

