module 0x72fdc4aef3df762d28773453b2e8651a29ec6bbd52e722c6e75a4053641bacc2::suimeme {
    struct SUIMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMEME>(arg0, 9, b"SUIMEME", b"SUI", b"Sui meme coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/126c66efa23faa86bb4aaf63c17cdbafblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIMEME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMEME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

