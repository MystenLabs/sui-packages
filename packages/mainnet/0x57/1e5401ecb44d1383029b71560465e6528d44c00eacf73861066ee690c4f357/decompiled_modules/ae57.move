module 0x571e5401ecb44d1383029b71560465e6528d44c00eacf73861066ee690c4f357::ae57 {
    struct AE57 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AE57, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AE57>(arg0, 9, b"AE57", b"ik756", b"j76e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d041ae637257e87bc325755f06278523blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AE57>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AE57>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

