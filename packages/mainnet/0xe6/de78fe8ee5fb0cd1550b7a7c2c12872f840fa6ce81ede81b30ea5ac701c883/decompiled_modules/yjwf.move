module 0xe6de78fe8ee5fb0cd1550b7a7c2c12872f840fa6ce81ede81b30ea5ac701c883::yjwf {
    struct YJWF has drop {
        dummy_field: bool,
    }

    fun init(arg0: YJWF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YJWF>(arg0, 9, b"YJWF", b"hejd", b"hdnd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dce66f39-cace-4c9d-ac37-35a0ba1e9fbd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YJWF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YJWF>>(v1);
    }

    // decompiled from Move bytecode v6
}

