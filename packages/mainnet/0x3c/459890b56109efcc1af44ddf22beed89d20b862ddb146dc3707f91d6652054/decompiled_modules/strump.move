module 0x3c459890b56109efcc1af44ddf22beed89d20b862ddb146dc3707f91d6652054::strump {
    struct STRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRUMP>(arg0, 6, b"STRUMP", b"TRUMP ON SUI", b"In the vast universe of meme coins, STRUMP emerged as a strange phenomenon on the MovePump platform. With the iconic image of Mr. Donald Trump riding a whale in the vast ocean, STRUMP quickly attracted the attention of the cryptocurrency community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/MONKEY_842df50621.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

