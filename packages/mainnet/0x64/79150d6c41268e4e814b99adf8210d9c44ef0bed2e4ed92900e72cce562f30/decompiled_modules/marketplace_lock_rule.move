module 0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_lock_rule {
    struct Rule has drop {
        dummy_field: bool,
    }

    struct Config has drop, store {
        dummy_field: bool,
    }

    public fun add<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: &0xf488ee79d75db15b702971da8db7800bce407968c62befcbd97298db48b11c69::admin::Admins, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0xf488ee79d75db15b702971da8db7800bce407968c62befcbd97298db48b11c69::admin::is_admin(arg2, &v0), 13906834286012530689);
        let v1 = Rule{dummy_field: false};
        let v2 = Config{dummy_field: false};
        0x2::transfer_policy::add_rule<T0, Rule, Config>(v1, arg0, arg1, v2);
    }

    public fun prove<T0>(arg0: &mut 0x2::transfer_policy::TransferRequest<T0>, arg1: &0x2::kiosk::Kiosk) {
        let v0 = 0x2::transfer_policy::item<T0>(arg0);
        assert!(0x2::kiosk::has_item(arg1, v0) && 0x2::kiosk::is_locked(arg1, v0), 13906834376206974979);
        let v1 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v1, arg0);
    }

    public fun prove_burn<T0>(arg0: &0x2::kiosk::KioskOwnerCap, arg1: &mut 0x2::transfer_policy::TransferRequest<T0>) {
        let v0 = Rule{dummy_field: false};
        0x2::transfer_policy::add_receipt<T0, Rule>(v0, arg1);
    }

    public fun remove<T0>(arg0: &mut 0x2::transfer_policy::TransferPolicy<T0>, arg1: &0x2::transfer_policy::TransferPolicyCap<T0>, arg2: &0xf488ee79d75db15b702971da8db7800bce407968c62befcbd97298db48b11c69::admin::Admins, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0xf488ee79d75db15b702971da8db7800bce407968c62befcbd97298db48b11c69::admin::is_admin(arg2, &v0), 13906834333257170945);
        0x2::transfer_policy::remove_rule<T0, Rule, Config>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

