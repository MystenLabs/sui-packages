module 0x8beb92885f9294b4e5cf21db9a9e18fb341f1196a1d4772e4b923a9a558ff8cf::popo {
    struct POPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POPO>(arg0, 6, b"POPO", b"Popo the pepe", b"POPO  the Independent wife of PEPE ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000128335_19325d06d7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

