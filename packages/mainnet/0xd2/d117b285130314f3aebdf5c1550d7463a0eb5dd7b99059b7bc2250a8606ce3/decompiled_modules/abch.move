module 0xd2d117b285130314f3aebdf5c1550d7463a0eb5dd7b99059b7bc2250a8606ce3::abch {
    struct ABCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ABCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ABCH>(arg0, 6, b"ABCH", b"Test ABV", b"Hello shop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaaanx6zk2ms53kiwrrwyy2re53zjz46rwlwuv2pyc5bmewx4p5fq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ABCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ABCH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

