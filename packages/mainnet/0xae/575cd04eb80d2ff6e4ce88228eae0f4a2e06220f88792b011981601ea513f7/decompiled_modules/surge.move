module 0xae575cd04eb80d2ff6e4ce88228eae0f4a2e06220f88792b011981601ea513f7::surge {
    struct SURGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SURGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SURGE>(arg0, 9, b"SURGE", b"SuiSurge", b"SuiSurge (SURGE) SuiSurge is a fast, low-cost digital asset on the Sui blockchain, designed to support scalable decentralized applications and drive Web3 innovation. Perfect for secure, efficient transactions in the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1756945653484355584/_jLAwAFo.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SURGE>(&mut v2, 1400000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SURGE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SURGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

