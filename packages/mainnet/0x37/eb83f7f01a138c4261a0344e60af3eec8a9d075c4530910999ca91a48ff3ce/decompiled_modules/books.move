module 0x37eb83f7f01a138c4261a0344e60af3eec8a9d075c4530910999ca91a48ff3ce::books {
    struct BOOKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOKS>(arg0, 6, b"BOOKS", b"DeepBook", b"Gm to those who still gm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_1_6c966aa969.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

