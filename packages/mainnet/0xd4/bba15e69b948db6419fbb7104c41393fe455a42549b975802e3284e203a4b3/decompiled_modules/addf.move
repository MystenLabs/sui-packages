module 0xd4bba15e69b948db6419fbb7104c41393fe455a42549b975802e3284e203a4b3::addf {
    struct ADDF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ADDF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ADDF>(arg0, 9, b"ADDF", b"Cat200", x"f09fa491f09fa491", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/264f4abd-5f82-4f1b-a9a3-c400d85e75ab.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ADDF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ADDF>>(v1);
    }

    // decompiled from Move bytecode v6
}

