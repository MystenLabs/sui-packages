module 0x6eff86855765292e5fb0a7993b21c43293bfc385a268d6827bf25f00d802a05e::wagmi {
    struct WAGMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAGMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAGMI>(arg0, 6, b"WAGMI", b"WAGMI on SUI", b"WAGMI on Sui is the new wave of wealth-building on the blockchain, where the legendary Wojak is not just surviving but thriving. With the power of Suis high-speed, low-cost infrastructure, Wojak is depicted in the ultimate comeback storyprinting money and riding the wave of riches thanks to this token. WAGMI embodies the spirit of Were All Gonna Make It, turning memes into fortunes and giving every holder a front-row seat to financial success. Get in on the action, because with WAGMI on Sui, everyone wins!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_26_04_12_34_980d3d0607.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAGMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAGMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

