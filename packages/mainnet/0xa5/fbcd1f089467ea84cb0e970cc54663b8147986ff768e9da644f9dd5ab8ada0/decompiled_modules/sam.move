module 0xa5fbcd1f089467ea84cb0e970cc54663b8147986ff768e9da644f9dd5ab8ada0::sam {
    struct SAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAM>(arg0, 9, b"SAM", b"SAMURAI", b"I'm SAMURAI!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/11e1ecf7b90c12de1387f8c781d12628blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

