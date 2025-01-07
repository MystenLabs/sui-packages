module 0x11d5dafdd094142e40a2e61a03bfca95950628bbe1306346b43d80136028d997::milady {
    struct MILADY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILADY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILADY>(arg0, 6, b"MILADY", b"There is no meme. I love you.", b"There is no meme. I love you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/media/FvyerU8WcAIXyu8.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MILADY>(&mut v2, 777777778000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILADY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILADY>>(v1);
    }

    // decompiled from Move bytecode v6
}

