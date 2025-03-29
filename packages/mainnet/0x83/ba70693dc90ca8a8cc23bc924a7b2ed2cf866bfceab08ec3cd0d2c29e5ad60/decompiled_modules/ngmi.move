module 0x83ba70693dc90ca8a8cc23bc924a7b2ed2cf866bfceab08ec3cd0d2c29e5ad60::ngmi {
    struct NGMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGMI>(arg0, 9, b"NGMI", b"Regret", b"Dont buy, Die BRoke", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/58d972c61aedb4b1899d0279c80c007cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NGMI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGMI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

