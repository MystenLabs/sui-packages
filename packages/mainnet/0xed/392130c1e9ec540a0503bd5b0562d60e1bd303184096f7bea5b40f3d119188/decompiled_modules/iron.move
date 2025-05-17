module 0xed392130c1e9ec540a0503bd5b0562d60e1bd303184096f7bea5b40f3d119188::iron {
    struct IRON has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IRON>(arg0, 6, b"IRON", b"IRON MAN", b"MARVEL IRON MAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiaaanx6zk2ms53kiwrrwyy2re53zjz46rwlwuv2pyc5bmewx4p5fq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<IRON>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

