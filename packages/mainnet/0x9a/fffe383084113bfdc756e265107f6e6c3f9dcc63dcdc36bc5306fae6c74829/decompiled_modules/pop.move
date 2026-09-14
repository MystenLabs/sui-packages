module 0x9afffe383084113bfdc756e265107f6e6c3f9dcc63dcdc36bc5306fae6c74829::pop {
    struct POP has drop {
        dummy_field: bool,
    }

    fun init(arg0: POP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POP>(arg0, 6, b"POP", b"SCat", x"48652063616d6520666f722074686520666973682e0a48652073746179656420666f7220746865206d656d65732e0a4e6f77206865206f776e73207468652053756920636861696e2e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aggregator.walrus-testnet.walrus.space/v1/blobs/Qfn5PsPN75nfuSKccxIBh2nu20F3vjijryO8xkj758w")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<POP>>(0x2::coin::mint<POP>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POP>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POP>>(v1);
    }

    // decompiled from Move bytecode v7
}

