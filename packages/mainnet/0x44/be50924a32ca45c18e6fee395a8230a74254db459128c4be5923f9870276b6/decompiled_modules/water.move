module 0x44be50924a32ca45c18e6fee395a8230a74254db459128c4be5923f9870276b6::water {
    struct WATER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATER>(arg0, 6, b"WATER", b"Sui Water", b"Sui water is a project that reminds people to drink water and live healthy we are all about the community. We will work to bring utility and value to our community. Did you know the name Sui, pronounced sw in English, is derived from a Japanese word for the element of water. $WATER COMMUNITY ENJOY THE RIDE!!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6148_ee4d2c31b5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WATER>>(v1);
    }

    // decompiled from Move bytecode v6
}

