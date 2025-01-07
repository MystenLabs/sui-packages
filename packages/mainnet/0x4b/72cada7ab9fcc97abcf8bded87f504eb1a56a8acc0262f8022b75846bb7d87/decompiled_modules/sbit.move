module 0x4b72cada7ab9fcc97abcf8bded87f504eb1a56a8acc0262f8022b75846bb7d87::sbit {
    struct SBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBIT>(arg0, 9, b"SBIT", b"SuiBit", b"SuiBit (SBIT) is the utility token for the Sui blockchain, used for governance and paying transaction fees (gas). It powers fast, secure transactions and supports DeFi, NFTs, and decentralized applications across the Sui ecosystem. SuiBit enables seamless interaction within the network while ensuring efficient and low-cost operations.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/520884164/bird.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SBIT>(&mut v2, 300000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBIT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

