module 0x4bd34300e603a6a1ddf066f59c368f7c8e167ddaf89fdea3d2b1a9f2209d5f40::pepefloki {
    struct PEPEFLOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEFLOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEFLOKI>(arg0, 6, b"PEPEFLOKI ", b"PEPE FLOKI ", b"PEPE FLOKI  belongs to the entire community, and the development team will give up control after initialization.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/4MOYCBR.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPEFLOKI>>(v1);
        0x2::coin::mint_and_transfer<PEPEFLOKI>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEPEFLOKI>>(v2);
    }

    // decompiled from Move bytecode v6
}

