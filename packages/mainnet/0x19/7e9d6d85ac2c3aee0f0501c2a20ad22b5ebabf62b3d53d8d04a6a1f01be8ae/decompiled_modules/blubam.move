module 0x197e9d6d85ac2c3aee0f0501c2a20ad22b5ebabf62b3d53d8d04a6a1f01be8ae::blubam {
    struct BLUBAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUBAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUBAM>(arg0, 6, b"BLUBAM", b"BLUBAM SUI", b"The OG FISH Coin on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/06d2430970ecf462907ac891d84698ff_82e6dab71b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUBAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUBAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

