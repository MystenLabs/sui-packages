module 0xa136be3274bd0946c4447145410963b11664d21754a8687d4626971d6c0c5cf8::killz {
    struct KILLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: KILLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KILLZ>(arg0, 6, b"KILLZ", b"Kill Zero", b"KILL ZERO IS A SUPER POWERFUL MEME TOKEN ON SUI NETWORK. $KILLZ  WILL BE THE RIGHT CHOICE FOR EVERY MEME CRYPTOCURRENCY LOVER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037354_bee28e044b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KILLZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KILLZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

