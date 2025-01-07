module 0xa65a63bb901df2f0e529feb20878c1580e1833a864d9759eb262a46ca4777128::suix {
    struct SUIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIX>(arg0, 9, b"SuiX", b"SuiX", b"SuiX (Sui Exchange Token) is a decentralized digital asset built on the Sui blockchain, designed to empower fast, secure, and scalable transactions across the network. SuiX is tailored for seamless integration within decentralized exchanges (DEXs), payment systems, and DeFi applications on the Sui ecosystem.  Key features include:  Low Transaction Fees: Leveraging Sui's high-performance infrastructure, SuiX offers cost-efficient transfers and smart contract interactions.  Scalability: Built on the scalable architecture of Sui, SuiX is designed to handle a growing number of users and transactions with ease.  Liquidity and Trading: Ideal for DEX operations and liquidity pools, ensuring users can trade and exchange assets smoothly.  Utility: Can be used for staking, governance participation, or fee payments within decentralized applications.  Secure and Transparent: Backed by the robust security model of the Sui blockchain, ensuring user assets are protected with transparent and immutable transactions.   SuiX is poised to become a core token for DeFi innovation on Sui, enabling users to participate in the growing decentralized economy with confidence and ease.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1639668819462615040/4YzPm1SZ.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIX>(&mut v2, 21000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

