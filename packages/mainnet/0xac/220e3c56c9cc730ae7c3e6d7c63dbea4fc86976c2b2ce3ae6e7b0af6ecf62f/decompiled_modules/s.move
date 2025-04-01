module 0xac220e3c56c9cc730ae7c3e6d7c63dbea4fc86976c2b2ce3ae6e7b0af6ecf62f::s {
    struct S has drop {
        dummy_field: bool,
    }

    fun init(arg0: S, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S>(arg0, 9, b"S", b"SUimon", b"10", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d98fb33ba69e57ccb3a4f2caafdd54e8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<S>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

