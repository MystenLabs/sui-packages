module 0xf71f973f05749a6288cb6e4fc147a161d2e2f3950a9582578102202c18d01f46::my {
    struct MY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MY>(arg0, 9, b"My", b"monky", b"kekekek kek monke", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a38a05d14d2e7e3c3c5ae8e5731bd2a8blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

