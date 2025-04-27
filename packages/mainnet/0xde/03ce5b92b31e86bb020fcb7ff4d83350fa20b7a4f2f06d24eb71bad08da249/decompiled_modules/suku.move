module 0xde03ce5b92b31e86bb020fcb7ff4d83350fa20b7a4f2f06d24eb71bad08da249::suku {
    struct SUKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUKU>(arg0, 9, b"Suku", b"Sukuful", b"Sukuful's dearly meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/fcb9e46f433dfa200688b12508140efcblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUKU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUKU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

