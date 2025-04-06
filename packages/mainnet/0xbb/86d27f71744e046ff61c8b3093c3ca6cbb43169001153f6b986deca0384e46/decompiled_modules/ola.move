module 0xbb86d27f71744e046ff61c8b3093c3ca6cbb43169001153f6b986deca0384e46::ola {
    struct OLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLA>(arg0, 9, b"OLA", b"OlaZ", b"OLa Zorza coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/46b2aa1eb45d8e6311ba311b4b8680e4blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OLA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

