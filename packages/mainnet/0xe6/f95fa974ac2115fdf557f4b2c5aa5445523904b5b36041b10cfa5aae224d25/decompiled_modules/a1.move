module 0xe6f95fa974ac2115fdf557f4b2c5aa5445523904b5b36041b10cfa5aae224d25::a1 {
    struct A1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: A1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A1>(arg0, 9, b"A1", b"all in one", b"for all nice person", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/0f45bff356fde17973c8c27821c02a7bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A1>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A1>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

