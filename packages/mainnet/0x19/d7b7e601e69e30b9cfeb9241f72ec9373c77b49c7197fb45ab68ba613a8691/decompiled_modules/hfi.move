module 0x19d7b7e601e69e30b9cfeb9241f72ec9373c77b49c7197fb45ab68ba613a8691::hfi {
    struct HFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFI>(arg0, 9, b"HFI", b"Hifi", x"4869666920697320612066726573682c20636f6d6d756e6974792d64726976656e206d656d6520636f696e20626c656e64696e672068756d6f7220616e642063727970746f20696e6e6f766174696f6e2e204a6f696e206e6f7720666f722066756e2c20726577617264732c20616e6420766972616c20706f74656e7469616c20696e2074686520626c6f636b636861696e20776f726c642120f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9229f07e-bda2-4ec8-a168-3382bbad2e45.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

