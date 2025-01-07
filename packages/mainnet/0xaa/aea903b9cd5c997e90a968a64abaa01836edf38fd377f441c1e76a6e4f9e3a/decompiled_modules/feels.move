module 0xaaaea903b9cd5c997e90a968a64abaa01836edf38fd377f441c1e76a6e4f9e3a::feels {
    struct FEELS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEELS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEELS>(arg0, 6, b"FEELS", b"FEELS MEME COIN", x"4c65742773206d616b65204d454d45206f6e2053554920477265617420416761696e202120244645454c530a546865204f6e6c7920526576657273656420576f6a616b20696e207468652053554920576f726c642e204173206d6f72652070656f706c65206a6f696e2075732c2074686520706f73736962696c69746965732061726520656e646c6573732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_20_51_30_c940c5bd51.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEELS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FEELS>>(v1);
    }

    // decompiled from Move bytecode v6
}

