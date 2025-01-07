module 0x53caf92016c338ca6fe40911c859de571fb35810d56f84908690de7978f6f059::testt {
    struct TESTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESTT>(arg0, 9, b"testt", b"tes", b"test", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/en/thumb/5/5f/Original_Doge_meme.jpg/220px-Original_Doge_meme.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TESTT>(&mut v2, 100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESTT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

