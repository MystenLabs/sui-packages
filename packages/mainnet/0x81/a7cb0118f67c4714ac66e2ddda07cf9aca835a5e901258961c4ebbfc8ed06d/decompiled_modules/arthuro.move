module 0x81a7cb0118f67c4714ac66e2ddda07cf9aca835a5e901258961c4ebbfc8ed06d::arthuro {
    struct ARTHURO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARTHURO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARTHURO>(arg0, 6, b"Arthuro", b"SUIDOG", x"426f726e2066726f6d205361746f736869204e616b616d6f746fe2809973207363726962626c6573206f6e2061207069656365206f66207061706572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreidal7w7nkkbrkhywryixoz6batiqeacylrf2fwwi5ixjeblfz5n6u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARTHURO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ARTHURO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

