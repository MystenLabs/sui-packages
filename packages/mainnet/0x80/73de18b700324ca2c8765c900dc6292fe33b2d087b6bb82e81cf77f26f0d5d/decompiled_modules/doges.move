module 0x8073de18b700324ca2c8765c900dc6292fe33b2d087b6bb82e81cf77f26f0d5d::doges {
    struct DOGES has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGES>(arg0, 9, b"DOGES", b"Doge on Sui", b"Best Dog On Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://upload.wikimedia.org/wikipedia/en/thumb/5/5f/Original_Doge_meme.jpg/220px-Original_Doge_meme.jpg"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGES>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOGES>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGES>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

