module 0x84eef7f3b388da4a463844631a35367cfa4d27b3da7aae093305e561c1f4e4ca::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOON>(arg0, 6, b"MOON", b"MOONBAGS", b"Moonbags is here to change the game - making Sui the go-to blockchain for traders by ensuring long-term value for both creators and holders", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ddf91483_4ad5_496a_be37_41be90cc9e40_b60f3cb537.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOON>>(v1);
    }

    // decompiled from Move bytecode v6
}

