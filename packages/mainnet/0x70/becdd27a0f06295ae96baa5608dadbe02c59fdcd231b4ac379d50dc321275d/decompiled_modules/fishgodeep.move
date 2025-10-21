module 0x70becdd27a0f06295ae96baa5608dadbe02c59fdcd231b4ac379d50dc321275d::fishgodeep {
    struct FISHGODEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHGODEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHGODEEP>(arg0, 9, b"FishGoDeep", b"FISHGODEEP", b"Sui fish go deep.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1761067860/sui_tokens/bv8libjh1dnelqbku8wz.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<FISHGODEEP>>(0x2::coin::mint<FISHGODEEP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<FISHGODEEP>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FISHGODEEP>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

