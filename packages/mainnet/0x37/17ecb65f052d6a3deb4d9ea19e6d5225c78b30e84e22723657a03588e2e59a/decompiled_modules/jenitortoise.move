module 0x3717ecb65f052d6a3deb4d9ea19e6d5225c78b30e84e22723657a03588e2e59a::jenitortoise {
    struct JENITORTOISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: JENITORTOISE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JENITORTOISE>(arg0, 6, b"Jenitortoise", b"JNG", b"Don't sleep at night and wash the turtle together.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000012821_0ecbea97a2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JENITORTOISE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JENITORTOISE>>(v1);
    }

    // decompiled from Move bytecode v6
}

