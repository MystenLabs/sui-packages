module 0x56e2e2a6e09c53365022e9dd04c7ae0daab0f441f67c76b69e7a0ccbd1c5c897::pds {
    struct PDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDS>(arg0, 9, b"PDS", b"PandaSui", b"PandaSui is a playful memecoin on the Sui blockchain. Join us to earn rewards with \"Bamboo Harvesting\" staking, collect unique panda NFTs, and participate in our community-driven PandaDAO. Enjoy a fun crypto experience!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e373877c-da7d-4d4d-bcbf-f77416424a2e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PDS>>(v1);
    }

    // decompiled from Move bytecode v6
}

