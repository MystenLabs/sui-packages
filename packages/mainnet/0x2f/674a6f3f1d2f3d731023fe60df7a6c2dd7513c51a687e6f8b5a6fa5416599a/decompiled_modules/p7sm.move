module 0x2f674a6f3f1d2f3d731023fe60df7a6c2dd7513c51a687e6f8b5a6fa5416599a::p7sm {
    struct P7SM has drop {
        dummy_field: bool,
    }

    fun init(arg0: P7SM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<P7SM>(arg0, 9, b"P7SM", b"7suima", b"7suima is my first token ok 7K sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/8ec11ad2d04c81b27bd05837469fe1ccblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<P7SM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<P7SM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

