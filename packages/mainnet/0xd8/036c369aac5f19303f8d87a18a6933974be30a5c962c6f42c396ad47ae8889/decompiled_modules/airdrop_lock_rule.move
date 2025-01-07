module 0xd8036c369aac5f19303f8d87a18a6933974be30a5c962c6f42c396ad47ae8889::airdrop_lock_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        airdrop_id: 0x2::object::ID,
    }

    public fun airdrop<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0xd8036c369aac5f19303f8d87a18a6933974be30a5c962c6f42c396ad47ae8889::airdrop::Airdrop, arg2: &0xd8036c369aac5f19303f8d87a18a6933974be30a5c962c6f42c396ad47ae8889::airdrop::AirdropCap, arg3: T0, arg4: &mut 0x2::transfer_policy::TransferRequest<T0>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::transfer_policy::item<T0>(arg4) == 0x2::object::id<T0>(&arg3), 1);
        let v0 = Rule{dummy_field: false};
        assert!(0x2::object::id<0xd8036c369aac5f19303f8d87a18a6933974be30a5c962c6f42c396ad47ae8889::airdrop::Airdrop>(arg1) == 0x2::transfer_policy::get_rule<T0, Rule, Config>(v0, arg0).airdrop_id, 0);
        let v1 = 0xd8036c369aac5f19303f8d87a18a6933974be30a5c962c6f42c396ad47ae8889::airdrop::airdrop(arg1, arg2);
        let (v2, v3) = 0x2::kiosk::new(arg5);
        let v4 = v3;
        let v5 = v2;
        0x2::kiosk::set_owner_custom(&mut v5, &v4, v1);
        0x2::kiosk::lock<T0>(&mut v5, &v4, arg0, arg3);
        let v6 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v6, arg4);
        0x2::transfer::public_transfer<0x2::kiosk::KioskOwnerCap>(v4, v1);
        0x2::transfer::public_share_object<0x2::kiosk::Kiosk>(v5);
    }

    public entry fun add<T0: store + key>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: &0xd8036c369aac5f19303f8d87a18a6933974be30a5c962c6f42c396ad47ae8889::airdrop::Airdrop) {
        let v0 = Rule{dummy_field: false};
        let v1 = Config{airdrop_id: 0x2::object::id<0xd8036c369aac5f19303f8d87a18a6933974be30a5c962c6f42c396ad47ae8889::airdrop::Airdrop>(arg2)};
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v0, arg0, arg1, v1);
    }

    // decompiled from Move bytecode v6
}

