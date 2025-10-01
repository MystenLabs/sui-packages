module 0x97421c9e52f240bdb575c422cd037d355bc25867c74a72cdd477ed2471f1392e::marketplace_permission_ext {
    struct Extension has drop {
        dummy_field: bool,
    }

    public fun add(arg0: &mut 0x2::kiosk::Kiosk, arg1: &0x2::kiosk::KioskOwnerCap, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = Extension{dummy_field: false};
        0x2::kiosk_extension::add<Extension>(v0, arg0, arg1, 0x45f7707bfcb8a6135490324e20abc2b80a326df1f4bc86da2cff5da0d2eb7abe::config::ext_permission(), arg2);
    }

    public fun lock(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x98ef711e6115521833df3e83f6e8e653a6eb0bd6a7169b281a915b11c2a0755::nft::Item, arg2: &0x2::transfer_policy::TransferPolicy<0x98ef711e6115521833df3e83f6e8e653a6eb0bd6a7169b281a915b11c2a0755::nft::Item>) {
        assert!(0x2::kiosk_extension::can_lock<Extension>(arg0), 13906834350437171203);
        let v0 = Extension{dummy_field: false};
        0x2::kiosk_extension::lock<Extension, 0x98ef711e6115521833df3e83f6e8e653a6eb0bd6a7169b281a915b11c2a0755::nft::Item>(v0, arg0, arg1, arg2);
    }

    public fun place(arg0: &mut 0x2::kiosk::Kiosk, arg1: 0x98ef711e6115521833df3e83f6e8e653a6eb0bd6a7169b281a915b11c2a0755::nft::Item, arg2: &0x2::transfer_policy::TransferPolicy<0x98ef711e6115521833df3e83f6e8e653a6eb0bd6a7169b281a915b11c2a0755::nft::Item>) {
        abort 13906834311782334465
    }

    // decompiled from Move bytecode v6
}

