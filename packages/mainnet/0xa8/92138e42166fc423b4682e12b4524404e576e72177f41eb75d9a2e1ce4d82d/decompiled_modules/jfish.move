module 0xa892138e42166fc423b4682e12b4524404e576e72177f41eb75d9a2e1ce4d82d::jfish {
    struct JFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: JFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JFISH>(arg0, 6, b"JFish", b"Jelly Fish", x"426f726e20696e206c69717569642c206c6976657320696e2076696265730a4e6f20426f6e65732c204e6f20427261696e2c204a75737420666c6f6174696e67207468726f756768206c696665206c696b652c0a2230204761732e203130302520447269702e22", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiazbmibnki3jh7obg4hz4dwwtgktm22bvbp7zfzngu43ecfdrfzoi")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<JFISH>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

