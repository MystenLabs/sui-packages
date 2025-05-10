module 0x4b56af6a6c9fa8ab64f5aa486b952947456b7bbd0518cb448003006b4fb51fbf::asdw {
    struct ASDW has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASDW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASDW>(arg0, 6, b"ASDW", b"asd", b"as", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiepxpgev3zqp73bycedbcvaazl3xlajmxtuasn7azkd4rbhbdiwuy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASDW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ASDW>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

