module 0x7cfcd6a1a1646897ed2a563a5d0056c4073c980180846e102f330162e9879429::kuber {
    struct KUBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUBER>(arg0, 9, b"KuBer", b"Maganet", b"Layer 3 Project base on fast transaction on chain  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/9f2221bf451597aa45775ccdc6c3e3afblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KUBER>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUBER>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

