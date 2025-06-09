module 0xff94d7157eba00ed5b06164091c7d22da347e7f3b20977904b769d30d011aaed::sui1 {
    struct SUI1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI1>(arg0, 9, b"Sui1", b"sui sui", b"monster sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/889d07d47c0a15809e3de656e4004e19blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUI1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

