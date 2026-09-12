module 0x493ac24d200177d886f500219eb053495e8de28e2c8763b7c4be2081281301ec::rules {
    struct RoyaltyRule has drop {
        dummy_field: bool,
    }

    struct RoyaltyConfig has drop, store {
        bps: u16,
        recipient: address,
    }

    struct LockRule has drop {
        dummy_field: bool,
    }

    struct LockConfig has drop, store {
        dummy_field: bool,
    }

    public fun add_lock<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>) {
        let v0 = LockRule{dummy_field: false};
        let v1 = LockConfig{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, LockRule, LockConfig>(v0, arg0, arg1, v1);
    }

    public fun add_royalty<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: u16, arg3: address) {
        assert!(arg2 <= 10000, 102);
        let v0 = RoyaltyRule{dummy_field: false};
        let v1 = RoyaltyConfig{
            bps       : arg2,
            recipient : arg3,
        };
        0x2::transfer_policy::add_rule<T0, RoyaltyRule, RoyaltyConfig>(v0, arg0, arg1, v1);
    }

    public fun pay_royalty<T0>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: 0x2::coin::Coin<0x2::sui::SUI>) {
        let v0 = RoyaltyRule{dummy_field: false};
        let v1 = 0x2::transfer_policy::get_rule<T0, RoyaltyRule, RoyaltyConfig>(v0, arg0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= (((0x2::transfer_policy::paid<T0>(arg1) as u128) * (v1.bps as u128) / (10000 as u128)) as u64), 100);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, v1.recipient);
        let v2 = RoyaltyRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, RoyaltyRule>(v2, arg1);
    }

    public fun prove_lock<T0: store + key>(arg0: &0x2::transfer_policy::TransferPolicy<T0>, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>, arg2: &0x2::kiosk::Kiosk) {
        let v0 = LockRule{dummy_field: false};
        0x2::transfer_policy::get_rule<T0, LockRule, LockConfig>(v0, arg0);
        assert!(0x2::kiosk::has_item_with_type<T0>(arg2, 0x2::transfer_policy::item<T0>(arg1)) && 0x2::kiosk::is_locked(arg2, 0x2::transfer_policy::item<T0>(arg1)), 101);
        let v1 = LockRule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, LockRule>(v1, arg1);
    }

    public fun setup<T0>(arg0: &0x2::package::Publisher, arg1: u16, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::transfer_policy::new<T0>(arg0, arg3);
        let v2 = v1;
        let v3 = v0;
        let v4 = &mut v3;
        add_royalty<T0>(v4, &v2, arg1, arg2);
        let v5 = &mut v3;
        add_lock<T0>(v5, &v2);
        0x2::transfer::public_share_object<0x2::transfer_policy::TransferPolicy<T0>>(v3);
        0x2::transfer::public_transfer<0x2::transfer_policy::TransferPolicyCap<T0>>(v2, 0x2::tx_context::sender(arg3));
    }

    // decompiled from Move bytecode v7
}

