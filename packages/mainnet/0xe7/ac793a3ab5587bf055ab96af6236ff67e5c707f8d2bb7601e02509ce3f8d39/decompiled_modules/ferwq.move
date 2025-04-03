module 0xe7ac793a3ab5587bf055ab96af6236ff67e5c707f8d2bb7601e02509ce3f8d39::ferwq {
    struct FERWQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FERWQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FERWQ>(arg0, 9, b"FERWQ", b"ldyul", b"dyuk", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8af6310f8a00c283c07d70ebbd72ff22blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FERWQ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FERWQ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

