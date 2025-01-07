module 0x381cc07ffdf76b9b15b2e90a062b1dfa27b6f277f69770c050476e6bdb1b8bf5::pdog {
    struct PDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDOG>(arg0, 6, b"PDOG", b"Play Dog", b"Dive into our exclusive metaverse where you can earn PlayDog tokens by playing exciting games.  NFT Integration: Own rare NFTs and power up your experience in the PlayDog universe.  Community-Driven Rewards: Be a part of a thriving community where fun and financial growth come together", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000002321_7c58223994.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

