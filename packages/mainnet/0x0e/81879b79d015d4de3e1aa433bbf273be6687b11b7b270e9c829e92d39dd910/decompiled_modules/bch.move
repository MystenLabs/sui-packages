module 0xe81879b79d015d4de3e1aa433bbf273be6687b11b7b270e9c829e92d39dd910::bch {
    struct BCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCH>(arg0, 9, b"BCH", b"Bitcoin Cash", b"Bitcoin Cash is a fork of Bitcoin. That's all I know.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be-alpha.7k.fun/api/file-upload/3f2c82be5ff23771a49698b65aff331dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BCH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

