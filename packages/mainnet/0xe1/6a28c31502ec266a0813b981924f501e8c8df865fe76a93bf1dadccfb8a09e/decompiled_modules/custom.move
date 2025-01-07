module 0xe16a28c31502ec266a0813b981924f501e8c8df865fe76a93bf1dadccfb8a09e::custom {
    struct CUSTOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUSTOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUSTOM>(arg0, 9, b"CUSTOM", b"Customize Everything", b"Customize everything using Move in Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/c4c08d04ae8e60458b36a17e152a08e8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUSTOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUSTOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

