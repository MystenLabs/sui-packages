module 0x9d2ab709117c53640f3d050cd3cde109a54b4383a8b7bff48caadfcf0174913a::btceth {
    struct BTCETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCETH>(arg0, 6, b"Btceth", b"1Bsoon", b"Ok", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreia3xqeazm4lrhu2ner6va4zbrujw5cja7cbj3u45c7jzb5wunx7nm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCETH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BTCETH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

