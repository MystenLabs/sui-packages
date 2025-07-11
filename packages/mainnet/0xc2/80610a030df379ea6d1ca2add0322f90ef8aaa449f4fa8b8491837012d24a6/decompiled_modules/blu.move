module 0xc280610a030df379ea6d1ca2add0322f90ef8aaa449f4fa8b8491837012d24a6::blu {
    struct BLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLU>(arg0, 6, b"BLU", b"BLU ON SUI", b"In the depths of the SUI chain, a mysterious little being was born from pure blue energy. His name is BLU - a young chaotic guardian that carries a flame of unrealized force.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeih5rffyfplvcnvir3x6acfkg5ww2rmfnboz2pkdt2us5rtbs5posa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

