module 0xb0ef0616f39c39d1efb501c1d20e9d9b41fd4749002d06421cf1ec6dd79aaaac::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOON>(arg0, 6, b"MOON", b"MO ON sui", b"MOON On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://airnfts.s3.amazonaws.com/nft-images/The_Astronaut_2_1618999962304.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MOON>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOON>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

