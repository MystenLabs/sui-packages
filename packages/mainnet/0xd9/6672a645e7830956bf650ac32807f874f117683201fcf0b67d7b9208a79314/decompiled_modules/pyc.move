module 0xd96672a645e7830956bf650ac32807f874f117683201fcf0b67d7b9208a79314::pyc {
    struct PYC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PYC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PYC>(arg0, 6, b"PYC", b"Pokemon Yacht Club", b"Pokemon Yach Club", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiev66xfutwnckill2uijyo77bms5ptwizbu4d6jb2cqvk7ohcgnx4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PYC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PYC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

