module 0xd4a9d4b70ec66b0d4eb7e4587dddf5351a6c4d8f410528ed1f09634102e9074f::bomboo {
    struct BOMBOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOMBOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOMBOO>(arg0, 6, b"BOMBOO", b"bomboclat", x"424f4d424f4f20434c4154200a0a4272696e6773206261636b2073756920737a6e20677265617420616761696e202120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3532_2120141615.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOMBOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOMBOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

