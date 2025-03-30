module 0x7cbab1b411d565cddaba349f8b7e9118ceae3707f684b47b10c62494d9e121a6::snk {
    struct SNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNK>(arg0, 9, b"SNK", b"Snake", b"A good project", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/b1c3de23ccf200cdb46a1afad068d50fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

