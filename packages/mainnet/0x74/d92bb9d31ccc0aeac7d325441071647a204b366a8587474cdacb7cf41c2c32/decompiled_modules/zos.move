module 0x74d92bb9d31ccc0aeac7d325441071647a204b366a8587474cdacb7cf41c2c32::zos {
    struct ZOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZOS>(arg0, 9, b"ZOS", b"zostret", b"zzzzzzzzzzzzzz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/bb08bb41d852f2fb01e417f35561ccc8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZOS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZOS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

