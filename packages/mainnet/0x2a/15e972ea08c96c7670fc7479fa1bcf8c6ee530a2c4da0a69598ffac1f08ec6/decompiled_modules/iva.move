module 0x2a15e972ea08c96c7670fc7479fa1bcf8c6ee530a2c4da0a69598ffac1f08ec6::iva {
    struct IVA has drop {
        dummy_field: bool,
    }

    fun init(arg0: IVA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IVA>(arg0, 9, b"IVA", b"ivan", b"zzzzz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5e54c970159d2356bca509839e813b5dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IVA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IVA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

