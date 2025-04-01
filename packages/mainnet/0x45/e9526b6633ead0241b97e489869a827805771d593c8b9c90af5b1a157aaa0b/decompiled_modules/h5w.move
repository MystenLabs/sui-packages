module 0x45e9526b6633ead0241b97e489869a827805771d593c8b9c90af5b1a157aaa0b::h5w {
    struct H5W has drop {
        dummy_field: bool,
    }

    fun init(arg0: H5W, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<H5W>(arg0, 9, b"H5W", b"teikl", b"dtfjg", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/bce034ac3bc23f3b6543d7a698a16663blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<H5W>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<H5W>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

