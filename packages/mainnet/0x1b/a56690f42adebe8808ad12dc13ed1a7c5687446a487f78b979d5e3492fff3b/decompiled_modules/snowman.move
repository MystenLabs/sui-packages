module 0x1ba56690f42adebe8808ad12dc13ed1a7c5687446a487f78b979d5e3492fff3b::snowman {
    struct SNOWMAN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<SNOWMAN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<SNOWMAN>>(0x2::coin::mint<SNOWMAN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: SNOWMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNOWMAN>(arg0, 9, b"snowman", b"SNOWMAN", b"Winter is coming.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1758631612/sui_tokens/mdaysmmf6ob3qjwrityo.png"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SNOWMAN>>(0x2::coin::mint<SNOWMAN>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNOWMAN>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SNOWMAN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

