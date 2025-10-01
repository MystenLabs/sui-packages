module 0x6479150d6c41268e4e814b99adf8210d9c44ef0bed2e4ed92900e72cce562f30::marketplace_permission_ext {
    struct Extension has drop {
        dummy_field: bool,
    }

    public fun add(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Extension{dummy_field: false};
        0x2::kiosk_extension::add<Extension>(v0, arg0, arg1, 0x2817ecf73ac8c09bb9de348fca4bd04a9f6a175fd0f72ced208f0fa56196efd5::config::ext_permission(), arg2);
    }

    public fun lock(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item, arg2: &0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>) {
        assert!(0x2::kiosk_extension::can_lock<Extension>(arg0), 13906834350437171203);
        let v0 = Extension{dummy_field: false};
        0x2::kiosk_extension::lock<Extension, 0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>(v0, arg0, arg1, arg2);
    }

    public fun place(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item, arg2: &0x2::transfer_policy::TransferPolicy<0xdbe6f37007740789e461bc6bdc740634f13fefbb97d4124f96cd9f51c458f10::nft::Item>) {
        abort 13906834311782334465
    }

    // decompiled from Move bytecode v6
}

