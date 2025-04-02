module 0x4db1850096962d27e2c7e9369cf6d0729a8ad0aa17a0279244ebf7090523b23b::slpoter {
    struct SLPOTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLPOTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLPOTER>(arg0, 9, b"Slpoter", b"sleep otter", b"New meme in meme world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/84458d62666d0e781631d32a4c8e7dddblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SLPOTER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLPOTER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

