module 0xf58a104c1c140c2eb4e573b8004b6c4c1efe929558fa437da34396f742664c21::marsh {
    struct MARSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARSH>(arg0, 6, b"MARSH", b"Marsh coin", b"Inspired by an orange walrus in a hoodie, crafted by artist Matt Furie. Built for those who love art, community, and a touch of fun. Join the movement and be part of something creative! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000076267_4e524bdec3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

