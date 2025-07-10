module 0xfe90410e68940e7b5aa861d7daee666b71d2822c78a509ec2059787aa109a82c::mbst {
    struct MBST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBST>(arg0, 6, b"MBST", b"MrBeastonsui", b"Mr beast CEO of X", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihdyfnvacxwitzfzjxwdojqykcoddxlb2u5ko7u4ye3jxlebkloem")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MBST>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

