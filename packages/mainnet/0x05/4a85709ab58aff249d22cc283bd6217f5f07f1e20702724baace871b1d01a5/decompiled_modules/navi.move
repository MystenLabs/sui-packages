module 0x54a85709ab58aff249d22cc283bd6217f5f07f1e20702724baace871b1d01a5::navi {
    struct NAVI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAVI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAVI>(arg0, 9, b"NAVI", b"NAVI Protocol", x"556c74696d617465204465666920696e667261202353756920284c656e64696e67202b204c535444656669292e20244e4156582e204261636b6564206279200a406f6b785f76656e74757265730a200a406861736865645f6f6666696369616c0a2026200a4064616f66697665", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a27db5fc102ebb75aafd6541dd8ddd41blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAVI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAVI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

