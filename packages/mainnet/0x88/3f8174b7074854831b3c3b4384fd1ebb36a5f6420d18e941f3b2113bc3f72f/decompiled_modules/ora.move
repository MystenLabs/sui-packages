module 0x883f8174b7074854831b3c3b4384fd1ebb36a5f6420d18e941f3b2113bc3f72f::ora {
    struct ORA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORA>(arg0, 9, b"ORA", b"Orange", b"Sweet Orange", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/7973e1a819fe54873d4bdbfa97f1102cblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ORA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

