module 0xa0ea2a09e4ce1b19eb58f55986a049e537b925681e72fd3ebb853372fdee885c::alpu {
    struct ALPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALPU>(arg0, 6, b"ALPU", b"ALPUPINO", b"Alpupino (ALPU) is more than a meme coinits a movement. By blending humor, innovation, and community spirit, ALPU aims to establish itself as a dominant player in the crypto space. Join the family and be part of this exciting journey to the top.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000032650_1e8ec988df.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALPU>>(v1);
    }

    // decompiled from Move bytecode v6
}

