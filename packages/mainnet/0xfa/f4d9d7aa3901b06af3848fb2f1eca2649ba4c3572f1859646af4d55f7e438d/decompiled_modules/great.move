module 0xfaf4d9d7aa3901b06af3848fb2f1eca2649ba4c3572f1859646af4d55f7e438d::great {
    struct GREAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREAT>(arg0, 9, b"GREAT", b"Dr ", b"Bull run", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5a55afef-3f57-40cf-b2d2-002a2e101e69.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GREAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

