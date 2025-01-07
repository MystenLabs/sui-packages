module 0xcbc4f9be2709a1a0b94e172c4c3f7d342f82143253f7b1d15e3edabc8c66bf33::eggy {
    struct EGGY has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGGY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGGY>(arg0, 6, b"EGGY", b"EGGYO", b"A cute and delicious little egg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732542175915.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EGGY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGGY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

