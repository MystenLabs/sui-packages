module 0xf6e7fcac642280ba427bc1b3e158a169fa0624cad36cd79fc931aba3502880a5::homi {
    struct HOMI has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<HOMI>, arg1: 0x2::coin::Coin<HOMI>) {
        0x2::coin::burn<HOMI>(arg0, arg1);
    }

    fun init(arg0: HOMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOMI>(arg0, 9, b"HOMI", b"HOMITOKEN", b" The HOMI token is the native token of the HOMINIDS platform. It allows users to buy and sell Hominids NFTs, participate in wagering games to earn rewards, and interact with other platform features. HOMI will also be used for platform governance, allowing holders to vote on future updates and important decisions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ibb.co/pRt6NpQ/HomiCoin.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOMI>>(v1);
        let v3 = &mut v2;
        let v4 = 0x2::tx_context::sender(arg1);
        mint(v3, 22000000000000000, v4, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOMI>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<HOMI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<HOMI>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

