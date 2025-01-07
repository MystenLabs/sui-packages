module 0x62ac2fead525ff7a8001e8b6050e6a8b0ba7fdfbfd86a397a54524a3ed8cbc88::suicatbosu {
    struct SUICATBOSU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICATBOSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICATBOSU>(arg0, 6, b"SUICATBOSU", b"SUi CATBOSU", b"CATBOSU, is the incarnation of KABOSU, VIRAL SHIBA INU BEHIND 'DOGE' MEMES return from heaven as a CAT. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_17_00_34_04_8432269a68.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICATBOSU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICATBOSU>>(v1);
    }

    // decompiled from Move bytecode v6
}

