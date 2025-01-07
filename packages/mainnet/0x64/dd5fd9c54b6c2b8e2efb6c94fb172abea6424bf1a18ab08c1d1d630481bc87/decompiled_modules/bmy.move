module 0x64dd5fd9c54b6c2b8e2efb6c94fb172abea6424bf1a18ab08c1d1d630481bc87::bmy {
    struct BMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMY>(arg0, 6, b"BMY", b"Best Meme Yet", b"Game over.......", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Best_Meme_20c5b89049.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

