module 0x6134b314daeb93d4b824052170d35aa4767892e305a8ddf69c53a309436155de::space1 {
    struct SPACE1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPACE1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPACE1>(arg0, 9, b"Space1", b"space", b"space oddity meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/2f09ba7ccea008e4dfe58ff4c75ce3d0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPACE1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPACE1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

