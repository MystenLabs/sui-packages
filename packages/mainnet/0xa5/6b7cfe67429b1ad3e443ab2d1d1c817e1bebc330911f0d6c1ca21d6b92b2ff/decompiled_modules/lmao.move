module 0xa56b7cfe67429b1ad3e443ab2d1d1c817e1bebc330911f0d6c1ca21d6b92b2ff::lmao {
    struct LMAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LMAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LMAO>(arg0, 9, b"LMAO", b"LmaoEZ", b":D LMAO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9a2cf73f-c43b-4269-8e70-0116f5767911.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LMAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LMAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

