module 0xef5821dbac3d606c21651317fa4fe9b7ed929efba837be2bd68f421876f9e95e::bns {
    struct BNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNS>(arg0, 6, b"BNS", b"BananeSui", b"Hello! Join Banane in creating magic on Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_89d07322f9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

