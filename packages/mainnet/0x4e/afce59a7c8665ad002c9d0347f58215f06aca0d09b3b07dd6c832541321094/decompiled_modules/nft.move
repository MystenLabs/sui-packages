module 0x4eafce59a7c8665ad002c9d0347f58215f06aca0d09b3b07dd6c832541321094::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NFT>(arg0, 6, b"NFT", b"NFTs", b"CRAZIEST EVER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2025_05_16_144040_d83d8c6a5e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NFT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NFT>>(v1);
    }

    // decompiled from Move bytecode v6
}

