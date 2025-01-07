module 0xc3d967a47ec85ca869e1dbfbb8e3efe81f8d05b939eac74075187ed4d0424cb9::bhl {
    struct BHL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BHL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BHL>(arg0, 9, b"BHL", b"Bhullah ", b"It will be a meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d477fa1e-5c10-434d-add5-45b649d05f6f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BHL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BHL>>(v1);
    }

    // decompiled from Move bytecode v6
}

