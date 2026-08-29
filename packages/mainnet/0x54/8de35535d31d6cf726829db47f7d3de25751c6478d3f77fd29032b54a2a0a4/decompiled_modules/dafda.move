module 0x548de35535d31d6cf726829db47f7d3de25751c6478d3f77fd29032b54a2a0a4::dafda {
    struct DAFDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAFDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAFDA>(arg0, 6, b"DAFDA", b"dasfdaf", b"dafdasf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suipad.online/api/images/7c3be910a68380ab5265fca7a3f14e79558e470b5212c5e0e6fdc6da2b2fa1b4.jpg")), arg1);
        let v2 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAFDA>>(v0, v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DAFDA>>(v1, v2);
    }

    // decompiled from Move bytecode v7
}

