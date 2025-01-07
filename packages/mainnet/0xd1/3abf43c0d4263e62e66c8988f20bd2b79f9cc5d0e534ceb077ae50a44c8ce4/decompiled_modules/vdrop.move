module 0xd13abf43c0d4263e62e66c8988f20bd2b79f9cc5d0e534ceb077ae50a44c8ce4::vdrop {
    struct VDROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: VDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VDROP>(arg0, 6, b"VDROP", b"VDROP SUI", b"VDROP is a cutting-edge platform for NFT AirDrop, tailored for smooth integration with blockchain technology. It enables users to easily craft their exclusive NFT collections and implement dynamic campaign tactics for distributing these NFTs to the community. This revolutionary platform empowers creators, artists, and businesses to interact with their audience effectively and cultivate a robust community centered around their brand.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/venomdrop1_7ede35e5b5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VDROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VDROP>>(v1);
    }

    // decompiled from Move bytecode v6
}

