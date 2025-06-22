module 0x55cd786d3784d72c6dc1b138ca7cbc1966237ebfb40638d3fac4789f3b7bf393::m {
    struct M has drop {
        dummy_field: bool,
    }

    fun init(arg0: M, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<M>(arg0, 9, b"M", b"mersedes", b"bmw best cars in the world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/a385d43adba28d10702643e6b32cfc96blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<M>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<M>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

