module 0xcb3c179bfdc1f3637d3c6a8099d0b3039b33fc3e32a07efea87343016be92fde::bzz {
    struct BZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BZZ>(arg0, 9, b"BZZ", b"big brozzher", b"lol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/87c0d7bcd1c2181557d99de89bfede8fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BZZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BZZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

