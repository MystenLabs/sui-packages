module 0xc1f85b1a39f2e27384801577445b12e6f4524f6bc0da907f6cc7a71ac1955fcb::fifi {
    struct FIFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIFI>(arg0, 6, b"Fifi", b"FIFI", b"The Cutest Queen of the Ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1500x500_6b2f7c4378.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

