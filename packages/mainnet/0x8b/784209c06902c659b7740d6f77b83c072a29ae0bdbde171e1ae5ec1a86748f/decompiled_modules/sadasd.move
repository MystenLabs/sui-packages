module 0x8b784209c06902c659b7740d6f77b83c072a29ae0bdbde171e1ae5ec1a86748f::sadasd {
    struct SADASD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADASD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADASD>(arg0, 9, b"Sadasd", b"123123", b"213123123", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/4a9eed781e142266c584ffda9fd4a750blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SADASD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADASD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

