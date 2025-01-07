module 0x8f4ef80d6c5c2eab36172151f589b6e4c878c7b462f94d79892d9251e497d70d::als {
    struct ALS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALS>(arg0, 6, b"ALS", b"AKa Lab Sui", b"AKA Ventures is a venture capital firm focusing exclusively on early-stage blockchain project decentralized finance, Fintech startup, NFT, Gamefi and Web3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/akalabs_e9347ec0ef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALS>>(v1);
    }

    // decompiled from Move bytecode v6
}

