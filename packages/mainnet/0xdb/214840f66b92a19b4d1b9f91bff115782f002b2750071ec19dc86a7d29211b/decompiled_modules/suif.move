module 0xdb214840f66b92a19b4d1b9f91bff115782f002b2750071ec19dc86a7d29211b::suif {
    struct SUIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIF>(arg0, 6, b"SUIF", b"SUIFlow", b"SUIFlow is a digital asset functioning within the SUI blockchain ecosystem, used for paying transaction fees, staking to earn rewards, and providing voting rights in network development decisions. Additionally, this token allows users to interact with various decentralized applications (dApps) built on the SUI blockchain, supporting the network's primary goals of scalability and high performance in decentralized financial applications. The creation of the website, Twitter, and Telegram community is coming soon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cuplikan_layar_2024_10_08_233833_5d1425eff0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

