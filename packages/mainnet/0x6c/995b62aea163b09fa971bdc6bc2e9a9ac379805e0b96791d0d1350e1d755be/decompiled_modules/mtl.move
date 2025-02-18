module 0x6c995b62aea163b09fa971bdc6bc2e9a9ac379805e0b96791d0d1350e1d755be::mtl {
    struct MTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTL>(arg0, 9, b"MTL", b"Man trying his luck", b"Man trying his luck memecoi merely speculative investing wisely", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/eb0fceae3b72df84a0c1f7750f6ee01dblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

