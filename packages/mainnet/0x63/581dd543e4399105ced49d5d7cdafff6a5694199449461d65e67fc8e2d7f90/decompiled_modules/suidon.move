module 0x63581dd543e4399105ced49d5d7cdafff6a5694199449461d65e67fc8e2d7f90::suidon {
    struct SUIDON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDON>(arg0, 9, b"SUIDON", b"SUIDON", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1761214441/sui_tokens/ihnspjwt4uckjdtuimjk.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SUIDON>>(0x2::coin::mint<SUIDON>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUIDON>>(v2);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIDON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

