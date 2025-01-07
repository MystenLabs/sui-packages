module 0x1a2d7e956a10ce07b216eb37f0d67eaba8d28cf74e301ddde1d04d34da413f6f::ehhbbkk {
    struct EHHBBKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: EHHBBKK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EHHBBKK>(arg0, 9, b"EHHBBKK", b"yv hn", b"bibgj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0662dd0c-0bb1-4ead-bbc8-700b3c98c54e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EHHBBKK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EHHBBKK>>(v1);
    }

    // decompiled from Move bytecode v6
}

