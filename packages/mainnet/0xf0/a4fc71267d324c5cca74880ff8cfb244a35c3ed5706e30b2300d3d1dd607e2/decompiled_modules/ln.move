module 0xf0a4fc71267d324c5cca74880ff8cfb244a35c3ed5706e30b2300d3d1dd607e2::ln {
    struct LN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LN>(arg0, 9, b"LN", b"Leon", b"leon leon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a5057de788a69976d783ef164e2d9770blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

