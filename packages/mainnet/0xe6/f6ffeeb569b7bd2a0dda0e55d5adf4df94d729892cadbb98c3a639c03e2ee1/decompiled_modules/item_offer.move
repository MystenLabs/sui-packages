module 0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::item_offer {
    struct ItemOffer<phantom T0> has key {
        id: 0x2::object::UID,
        send_to: address,
        claim: 0x1::option::Option<0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::claim::Claim<T0>>,
        for_id: 0x1::option::Option<0x2::object::ID>,
        for_type: 0x1::option::Option<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>,
        amount_each: u64,
        quantity: u8,
        expiry_ms: u64,
    }

    struct Witness has drop {
        dummy_field: bool,
    }

    public fun cancel() {
    }

    public fun cancel_() {
    }

    public entry fun create_offer_() {
    }

    public fun is_type_offer<T0>(arg0: &ItemOffer<T0>) : bool {
        0x1::option::is_some<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>(&arg0.for_type)
    }

    public fun is_valid<T0>(arg0: &ItemOffer<T0>, arg1: &0x2::clock::Clock) : bool {
        if (0x1::option::is_none<0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::claim::Claim<T0>>(&arg0.claim)) {
            return false
        };
        if (0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::is_destroyed(&arg0.id)) {
            return false
        };
        if (0x2::clock::timestamp_ms(arg1) > arg0.expiry_ms) {
            return false
        };
        true
    }

    public fun make_offer<T0>(arg0: &mut 0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::coin23::Coin23<T0>, arg1: address, arg2: 0x1::option::Option<0x2::object::ID>, arg3: 0x1::option::Option<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>, arg4: u64, arg5: u8, arg6: u64, arg7: &0x2::clock::Clock, arg8: &0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::coin23::CurrencyRegistry, arg9: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority, arg10: &mut 0x2::tx_context::TxContext) : ItemOffer<T0> {
        if (0x1::option::is_some<0x2::object::ID>(&arg2)) {
            let v1 = 0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::claim::create<T0>(arg0, arg4, arg6, arg7, arg8, arg9, arg10);
            let (_, _, v4) = 0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::claim::info<T0>(&v1);
            ItemOffer<T0>{id: 0x2::object::new(arg10), send_to: arg1, claim: 0x1::option::some<0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::claim::Claim<T0>>(v1), for_id: arg2, for_type: 0x1::option::none<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>(), amount_each: arg4, quantity: 1, expiry_ms: v4}
        } else {
            assert!(0x1::option::is_some<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>(&arg3), 0);
            let v5 = 0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::claim::create<T0>(arg0, arg4 * (arg5 as u64), arg6, arg7, arg8, arg9, arg10);
            let (_, _, v8) = 0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::claim::info<T0>(&v5);
            ItemOffer<T0>{id: 0x2::object::new(arg10), send_to: arg1, claim: 0x1::option::some<0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::claim::Claim<T0>>(v5), for_id: 0x1::option::none<0x2::object::ID>(), for_type: arg3, amount_each: arg4, quantity: arg5, expiry_ms: v8}
        }
    }

    public fun object_offer_info<T0>(arg0: &ItemOffer<T0>) : (address, 0x2::object::ID, u64, u64) {
        (arg0.send_to, *0x1::option::borrow<0x2::object::ID>(&arg0.for_id), arg0.amount_each, arg0.expiry_ms)
    }

    public fun return_and_share<T0>(arg0: ItemOffer<T0>, arg1: address) {
        let v0 = Witness{dummy_field: false};
        let v1 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::begin_with_package_witness_<Witness>(v0);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::as_shared_object_<ItemOffer<T0>>(&mut arg0.id, 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::typed_id::new<ItemOffer<T0>>(&arg0), arg1, @0x0, &v1);
        0x2::transfer::share_object<ItemOffer<T0>>(arg0);
    }

    public fun take_offer<T0>(arg0: ItemOffer<T0>, arg1: &mut 0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::coin23::Coin23<T0>, arg2: &mut 0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::coin23::Coin23<T0>, arg3: &mut 0x2::object::UID, arg4: &0x2::clock::Clock, arg5: &0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::coin23::CurrencyRegistry, arg6: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.quantity == 1, 2);
        assert!(is_valid<T0>(&arg0, arg4), 2);
        let ItemOffer {
            id          : v0,
            send_to     : v1,
            claim       : v2,
            for_id      : v3,
            for_type    : v4,
            amount_each : v5,
            quantity    : _,
            expiry_ms   : _,
        } = arg0;
        let v8 = v4;
        let v9 = v3;
        0x2::object::delete(v0);
        if (0x1::option::is_some<0x2::object::ID>(&v9)) {
            assert!(0x1::option::borrow<0x2::object::ID>(&v9) == 0x2::object::uid_as_inner(arg3), 1);
        } else {
            let v10 = 0x1::option::destroy_some<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::get_type(arg3));
            assert!(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::match(0x1::option::borrow<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>(&v8), &v10), 1);
        };
        let v11 = 0x1::option::destroy_some<0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::claim::Claim<T0>>(v2);
        0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::claim::redeem_claim<T0>(&mut v11, arg1, arg2, v5, arg4, arg5, arg7);
        0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::claim::destroy<T0>(v11, arg1);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::transfer(arg3, 0x1::option::some<address>(v1), arg6);
    }

    public fun take_offer_<T0>(arg0: &mut ItemOffer<T0>, arg1: &mut 0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::coin23::Coin23<T0>, arg2: &mut 0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::coin23::Coin23<T0>, arg3: &mut 0x2::object::UID, arg4: &0x2::clock::Clock, arg5: &0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::coin23::CurrencyRegistry, arg6: &0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::TxAuthority, arg7: &mut 0x2::tx_context::TxContext) {
        assert!(is_valid<T0>(arg0, arg4), 2);
        if (0x1::option::is_some<0x2::object::ID>(&arg0.for_id)) {
            assert!(0x1::option::borrow<0x2::object::ID>(&arg0.for_id) == 0x2::object::uid_as_inner(arg3), 1);
        } else {
            let v0 = 0x1::option::destroy_some<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>(0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::get_type(arg3));
            assert!(0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::match(0x1::option::borrow<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>(&arg0.for_type), &v0), 1);
        };
        0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::claim::redeem_claim<T0>(0x1::option::borrow_mut<0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::claim::Claim<T0>>(&mut arg0.claim), arg1, arg2, arg0.amount_each, arg4, arg5, arg7);
        0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::transfer(arg3, 0x1::option::some<address>(arg0.send_to), arg6);
        arg0.quantity = arg0.quantity - 1;
        if (arg0.quantity == 0) {
            0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::claim::destroy<T0>(0x1::option::extract<0xe6f6ffeeb569b7bd2a0dda0e55d5adf4df94d729892cadbb98c3a639c03e2ee1::claim::Claim<T0>>(&mut arg0.claim), arg1);
            let v1 = 0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::tx_authority::empty();
            0x465af71e8e64609c2328a5d7e025b907551618f318896cdcea3b75e09c4e9593::ownership::destroy(&mut arg0.id, &v1);
        };
    }

    public fun type_offer_info<T0>(arg0: &ItemOffer<T0>) : (address, 0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag, u64, u8, u64) {
        (arg0.send_to, *0x1::option::borrow<0x6ba7321c8d88a990226633c2034c2a27094b6472cfdb1e73b779c44e92e4a113::struct_tag::StructTag>(&arg0.for_type), arg0.amount_each, arg0.quantity, arg0.expiry_ms)
    }

    // decompiled from Move bytecode v6
}

