module 0xca9592601bb320fac2d95f68f9a54578b1e16c37c5b3855671156ec84cdb665f::gmn {
    struct GMN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GMN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GMN>(arg0, 6, b"GMN", b"GEMINISUI", b"FOR GEMINI ONLY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gemini_fb5d11e171.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GMN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GMN>>(v1);
    }

    // decompiled from Move bytecode v6
}

