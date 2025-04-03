module 0x969c4ad996599cecc36eb47d5f32c915f5d838ec3f4cc512166de6b8bc7fbd39::wal2moon {
    struct WAL2MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAL2MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAL2MOON>(arg0, 9, b"WAL2MOON", b"Walrus To The Moon ", b"Loading...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b7159c20867138d327a4dfad20442d45blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAL2MOON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAL2MOON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

