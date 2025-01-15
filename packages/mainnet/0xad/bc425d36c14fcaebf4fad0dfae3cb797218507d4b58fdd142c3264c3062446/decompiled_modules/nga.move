module 0xadbc425d36c14fcaebf4fad0dfae3cb797218507d4b58fdd142c3264c3062446::nga {
    struct NGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NGA>(arg0, 9, b"NGA", b"WOMP WOMP NIGGA ", b"CUZ WHY TF  NOT ???", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0700b6d6f7c66dffd6272ff38c6bfb3bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NGA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

