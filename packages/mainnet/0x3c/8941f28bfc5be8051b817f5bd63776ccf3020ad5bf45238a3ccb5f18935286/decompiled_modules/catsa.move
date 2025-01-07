module 0x3c8941f28bfc5be8051b817f5bd63776ccf3020ad5bf45238a3ccb5f18935286::catsa {
    struct CATSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSA>(arg0, 6, b"CATSA", b"Cat Sakamoto", b"Cat Sakamoto is a beloved character from the Japanese manga series, Nichijou.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catclub_cee4aa27cc_515aae4938.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

