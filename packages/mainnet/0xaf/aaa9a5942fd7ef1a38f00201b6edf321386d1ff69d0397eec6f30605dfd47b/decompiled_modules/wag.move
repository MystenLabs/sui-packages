module 0xafaaa9a5942fd7ef1a38f00201b6edf321386d1ff69d0397eec6f30605dfd47b::wag {
    struct WAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAG>(arg0, 9, b"Wag", b"josepy", b"fuck layer 2 airdrops", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/291d6298e38a0c889f368b7fd004366fblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

