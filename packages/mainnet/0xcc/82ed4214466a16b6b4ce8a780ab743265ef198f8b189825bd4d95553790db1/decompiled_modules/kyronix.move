module 0xcc82ed4214466a16b6b4ce8a780ab743265ef198f8b189825bd4d95553790db1::kyronix {
    struct KYRONIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: KYRONIX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<KYRONIX>(arg0, 6, b"KYRONIX", b"Kyronix Agent by SuiAI", b"Kyronix assists users in automated trading with customizable parameters, such as setting stop-loss limits and profit targets, making it suitable for both beginner and professional traders. Additionally, Kyronix serves as a blockchain educator, providing interactive guidance to newcomers to help them understand concepts like blockchain, smart contracts, and the DeFi ecosystem. In a proof-of-stake-based blockchain ecosystem, Kyronix can act as a validator, ensuring transaction integrity and network security. With its multifunctional role, Kyronix is a symbol of innovation that bridges advanced technology with practical needs in the ever-evolving world of cryptocurrency.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_122_fb6639265c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KYRONIX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KYRONIX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

