module 0x3298ddc8a95310b71b07860da015db76ed3e8081dc1d927a4d0940928170fdae::mmc {
    struct MMC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MMC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MMC>(arg0, 9, b"MMC", b"MemeMirage", b"MemeMirage Coin (MMC) is an innovative and groundbreaking Meme cryptocurrency that leverages the power of humor, creativity, and the global meme culture to create an engaging and valuable", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/10c63930-c0a2-4235-b7ee-f5fbf3d903e2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MMC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MMC>>(v1);
    }

    // decompiled from Move bytecode v6
}

