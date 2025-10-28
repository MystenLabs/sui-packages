module 0xb457ce2dd55c67787f5d3a428dda465810860497b9fb5b4514c4fc3d991a66be::suimeon {
    struct SUIMEON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEON>(arg0, 9, b"SuiMeon", b"SUIMEON", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1761657690/sui_tokens/agrtfiogrdfdowdxglfe.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIMEON>>(0x2::coin::mint<SUIMEON>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIMEON>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIMEON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

