module 0xc09c347dea1accca224a831a92e300ffd2d9f6707828c42d1ff4a82a8096950b::memery {
    struct MEMERY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMERY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMERY>(arg0, 6, b"MEMERY", b"Sui Memery", b"Memery - Meme filled wonderland of the cryptoverse", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000513_c5046e6ac7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMERY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEMERY>>(v1);
    }

    // decompiled from Move bytecode v6
}

