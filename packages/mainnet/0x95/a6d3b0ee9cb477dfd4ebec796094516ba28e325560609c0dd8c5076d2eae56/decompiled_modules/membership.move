module 0x95a6d3b0ee9cb477dfd4ebec796094516ba28e325560609c0dd8c5076d2eae56::membership {
    struct MEMBERSHIP has drop {
        dummy_field: bool,
    }

    struct MembershipList has store, key {
        id: 0x2::object::UID,
        ownership: 0x95a6d3b0ee9cb477dfd4ebec796094516ba28e325560609c0dd8c5076d2eae56::ownership::CredenzaOwnership,
        members: 0x2::table::Table<address, 0x1::string::String>,
    }

    struct MembershipAddedEvent has copy, drop {
        membership_list_id: 0x2::object::ID,
        user: address,
        metadata: 0x1::string::String,
    }

    struct MembershipListCreatedEvent has copy, drop {
        membership_list_id: 0x2::object::ID,
    }

    struct MembershipRemovedEvent has copy, drop {
        membership_list_id: 0x2::object::ID,
        user: address,
        metadata: 0x1::string::String,
    }

    public fun buy_membership<T0>(arg0: &mut MembershipList, arg1: &0x95a6d3b0ee9cb477dfd4ebec796094516ba28e325560609c0dd8c5076d2eae56::sellable::CredenzaSellableConfig<MEMBERSHIP>, arg2: 0x2::coin::Coin<T0>, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, 0x1::string::String>(&arg0.members, v0), 1);
        0x95a6d3b0ee9cb477dfd4ebec796094516ba28e325560609c0dd8c5076d2eae56::sellable::accept_payment_coin<MEMBERSHIP, T0>(arg1, arg2, arg3);
        set_membership_internal(arg0, v0, 0x1::string::utf8(b""));
    }

    fun init(arg0: MEMBERSHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::new(arg1);
        let (_, v2) = 0x95a6d3b0ee9cb477dfd4ebec796094516ba28e325560609c0dd8c5076d2eae56::sellable::create_config<MEMBERSHIP>(arg0, arg1);
        let v3 = MembershipList{
            id        : v0,
            ownership : 0x95a6d3b0ee9cb477dfd4ebec796094516ba28e325560609c0dd8c5076d2eae56::ownership::create_ownership(0x2::object::uid_to_inner(&v0), arg1),
            members   : 0x2::table::new<address, 0x1::string::String>(arg1),
        };
        0x95a6d3b0ee9cb477dfd4ebec796094516ba28e325560609c0dd8c5076d2eae56::ownership::add_owner(&mut v3.ownership, 0x2::tx_context::sender(arg1));
        let v4 = MembershipListCreatedEvent{membership_list_id: 0x2::object::uid_to_inner(&v3.id)};
        0x2::event::emit<MembershipListCreatedEvent>(v4);
        0x2::transfer::share_object<MembershipList>(v3);
        0x2::transfer::public_share_object<0x95a6d3b0ee9cb477dfd4ebec796094516ba28e325560609c0dd8c5076d2eae56::sellable::CredenzaSellableConfig<MEMBERSHIP>>(v2);
    }

    public fun remove_membership(arg0: &mut MembershipList, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        0x95a6d3b0ee9cb477dfd4ebec796094516ba28e325560609c0dd8c5076d2eae56::ownership::assert_owner(&arg0.ownership, 0x2::tx_context::sender(arg2));
        if (0x2::table::contains<address, 0x1::string::String>(&arg0.members, arg1)) {
            let v0 = MembershipRemovedEvent{
                membership_list_id : 0x2::object::uid_to_inner(&arg0.id),
                user               : arg1,
                metadata           : 0x2::table::remove<address, 0x1::string::String>(&mut arg0.members, arg1),
            };
            0x2::event::emit<MembershipRemovedEvent>(v0);
        };
    }

    public fun set_membership(arg0: &mut MembershipList, arg1: address, arg2: 0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        0x95a6d3b0ee9cb477dfd4ebec796094516ba28e325560609c0dd8c5076d2eae56::ownership::assert_owner(&arg0.ownership, 0x2::tx_context::sender(arg3));
        set_membership_internal(arg0, arg1, arg2);
    }

    fun set_membership_internal(arg0: &mut MembershipList, arg1: address, arg2: 0x1::string::String) {
        if (0x2::table::contains<address, 0x1::string::String>(&arg0.members, arg1)) {
            0x2::table::remove<address, 0x1::string::String>(&mut arg0.members, arg1);
        } else {
            let v0 = MembershipAddedEvent{
                membership_list_id : 0x2::object::uid_to_inner(&arg0.id),
                user               : arg1,
                metadata           : arg2,
            };
            0x2::event::emit<MembershipAddedEvent>(v0);
        };
        0x2::table::add<address, 0x1::string::String>(&mut arg0.members, arg1, arg2);
    }

    public fun set_owner(arg0: &mut MembershipList, arg1: address, arg2: bool, arg3: &mut 0x2::tx_context::TxContext) {
        0x95a6d3b0ee9cb477dfd4ebec796094516ba28e325560609c0dd8c5076d2eae56::ownership::assert_owner(&arg0.ownership, 0x2::tx_context::sender(arg3));
        0x95a6d3b0ee9cb477dfd4ebec796094516ba28e325560609c0dd8c5076d2eae56::ownership::set_owner(&mut arg0.ownership, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

