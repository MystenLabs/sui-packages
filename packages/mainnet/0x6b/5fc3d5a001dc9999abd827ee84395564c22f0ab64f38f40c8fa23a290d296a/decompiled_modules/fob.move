module 0x6b5fc3d5a001dc9999abd827ee84395564c22f0ab64f38f40c8fa23a290d296a::fob {
    struct FOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOB>(arg0, 6, b"FOB", b"Fob The Alien", b"From home, I could always see Earth, a distant blue glow in the void. I often wondered what it would be like to stand here, to feel its air, its ground. Now I know.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000048857_35fa26ec68.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOB>>(v1);
    }

    // decompiled from Move bytecode v6
}

