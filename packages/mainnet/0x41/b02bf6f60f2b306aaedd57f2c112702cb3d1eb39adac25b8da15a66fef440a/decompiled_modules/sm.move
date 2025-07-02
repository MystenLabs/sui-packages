module 0x41b02bf6f60f2b306aaedd57f2c112702cb3d1eb39adac25b8da15a66fef440a::sm {
    struct SM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SM>(arg0, 9, b"SM", b"Smile", b"Keep smile every day.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ffeaf7dca31320fd4b9211ebe92a165ablob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

