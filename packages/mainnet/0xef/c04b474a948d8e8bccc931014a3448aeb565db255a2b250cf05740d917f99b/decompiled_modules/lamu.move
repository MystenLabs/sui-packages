module 0xefc04b474a948d8e8bccc931014a3448aeb565db255a2b250cf05740d917f99b::lamu {
    struct LAMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: LAMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LAMU>(arg0, 6, b"LAMU", b"LAMU MOROBOSHI", b"LAMU is an alien princess from planet Oniboshi, known for her green hair, cat-like ears, and tiger-striped bikini. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731939938737.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LAMU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LAMU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

