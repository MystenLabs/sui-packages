module 0x385c69acd33365038c304193c6d0517843c8b585da4993c56c2e69b2d64f7d23::blst {
    struct BLST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLST>(arg0, 6, b"BLST", b"BLUELOBSTER", b"Rare, vibrant, and totally unexpected, just like your portfolio gains", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_023359273_62d3b5ab14.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLST>>(v1);
    }

    // decompiled from Move bytecode v6
}

