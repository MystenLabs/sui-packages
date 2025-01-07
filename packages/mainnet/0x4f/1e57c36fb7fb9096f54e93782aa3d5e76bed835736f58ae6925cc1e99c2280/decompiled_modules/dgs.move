module 0x4f1e57c36fb7fb9096f54e93782aa3d5e76bed835736f58ae6925cc1e99c2280::dgs {
    struct DGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: DGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DGS>(arg0, 9, b"DGS", b"SAFAS", b"SDFGHS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/35b74e56-445b-4e32-9ede-6f7ce3765852.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

