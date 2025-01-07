module 0xff3c640fb1a59f27603618fa610b8aa8e4261007776893677ef1904d01155604::goldie {
    struct GOLDIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLDIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLDIE>(arg0, 6, b"GOLDIE", b"Goldie On Sui", b"Goldie aims to bring fun to the world of web3 so join the movement if you love fun and dogs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003207_125cd66e80.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLDIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLDIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

