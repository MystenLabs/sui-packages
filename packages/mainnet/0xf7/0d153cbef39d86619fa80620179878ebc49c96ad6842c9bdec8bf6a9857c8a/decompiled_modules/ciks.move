module 0xf70d153cbef39d86619fa80620179878ebc49c96ad6842c9bdec8bf6a9857c8a::ciks {
    struct CIKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIKS>(arg0, 6, b"CIKS", b"Ciks", b"Just a chill, natural chick. Its called $CIKS and it loves nature, especially long trees.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_10_05_T165214_210_1be8dd216e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

