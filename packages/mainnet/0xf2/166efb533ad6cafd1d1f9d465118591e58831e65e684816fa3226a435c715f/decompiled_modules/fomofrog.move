module 0xf2166efb533ad6cafd1d1f9d465118591e58831e65e684816fa3226a435c715f::fomofrog {
    struct FOMOFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOMOFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMOFROG>(arg0, 6, b"FOMOFROG", b"FOMO FROG", b"Introducing Fomo Frog, a lively and colorful meme token created on the Binance Smart Chain. https://www.instagram.com/fomofrog/", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1723659895444_f629ab015d1b237f5d38b161c57538c1_d0e78fb09c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMOFROG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOMOFROG>>(v1);
    }

    // decompiled from Move bytecode v6
}

