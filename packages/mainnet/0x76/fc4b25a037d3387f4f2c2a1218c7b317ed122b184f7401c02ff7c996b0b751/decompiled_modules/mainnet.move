module 0x76fc4b25a037d3387f4f2c2a1218c7b317ed122b184f7401c02ff7c996b0b751::mainnet {
    struct MAINNET has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAINNET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAINNET>(arg0, 0, b"MAINNET", b"MAINNETCOIN", b"THIS IS A COIN FOR TESTING", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://meme.rolipoli.xyz/meme-icons/1758397822546_meme7.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<MAINNET>>(0x2::coin::mint<MAINNET>(&mut v2, 99999, arg1), @0x6dc40a6b35310e5dd5cb7767f8d8477b9c1fc219f0cc511f45928eddaae341dd);
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<MAINNET>>(v2);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAINNET>>(v1);
    }

    // decompiled from Move bytecode v6
}

