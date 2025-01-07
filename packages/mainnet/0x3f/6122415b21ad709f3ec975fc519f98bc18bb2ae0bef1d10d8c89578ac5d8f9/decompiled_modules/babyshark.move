module 0x3f6122415b21ad709f3ec975fc519f98bc18bb2ae0bef1d10d8c89578ac5d8f9::babyshark {
    struct BABYSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYSHARK>(arg0, 6, b"BabyShark", b"SUI BBS", b"Come to BBS to play games and get tokens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/448c0d0540834249_8bda30d3c5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYSHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYSHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

