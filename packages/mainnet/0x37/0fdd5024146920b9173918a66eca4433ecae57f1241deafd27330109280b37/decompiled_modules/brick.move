module 0x370fdd5024146920b9173918a66eca4433ecae57f1241deafd27330109280b37::brick {
    struct BRICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRICK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRICK>(arg0, 6, b"BRICK", b"Brick", b"A nice brick to commemorate Sui Overflow 2025.", 0x1::option::some<0x2::url::Url>(0x370fdd5024146920b9173918a66eca4433ecae57f1241deafd27330109280b37::icon::get_icon_url()), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRICK>>(v3, 0x2::object::id_address<0x2::coin::CoinMetadata<BRICK>>(&v2));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRICK>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<BRICK>>(0x2::coin::mint<BRICK>(&mut v3, 1000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

