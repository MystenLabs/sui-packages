module 0xe73e27386100182f9924babd9cfcbdd77f2464d8c7611042530055e8c6e2d9b::rawcow {
    struct RAWCOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAWCOW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAWCOW>(arg0, 6, b"RAWCOW", b"MOONRAWCOW", b"RAWCOWWWWWWWWWWWWWWWWW", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihhv2ewxqjkpqnsifrjv2riqqfgx4vosyegsxwyusaps4hkeadpgy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAWCOW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<RAWCOW>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

