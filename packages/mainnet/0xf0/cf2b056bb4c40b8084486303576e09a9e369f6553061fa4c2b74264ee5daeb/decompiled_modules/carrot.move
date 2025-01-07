module 0xf0cf2b056bb4c40b8084486303576e09a9e369f6553061fa4c2b74264ee5daeb::carrot {
    struct CARROT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARROT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARROT>(arg0, 6, b"CARROT", b"Carrot", b"They Say, I am the cutest Carrot in Earth", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000010055_bec966822c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARROT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARROT>>(v1);
    }

    // decompiled from Move bytecode v6
}

