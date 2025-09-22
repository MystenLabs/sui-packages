module 0x975de0596ea5ef71b0820676a911b4c8808971b0da451352ceabc5e47fbbd1a6::JKR {
    struct JKR has drop {
        dummy_field: bool,
    }

    fun init(arg0: JKR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JKR>(arg0, 9, b"joker", b"JKR", b"JOKERMAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://res.cloudinary.com/ddjudhfru/image/upload/v1758540725/sui_tokens/mdvbwn6j3dbxiwrcydqy.jpg"))), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<JKR>>(0x2::coin::mint<JKR>(&mut v2, 100000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JKR>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JKR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

