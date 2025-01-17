module 0x2d1ac57978ea3d8853240b27ac5ae7ecc23eb0d7b8cd8ab7247d2ef8d079da07::rei {
    struct REI has drop {
        dummy_field: bool,
    }

    fun init(arg0: REI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<REI>(arg0, 6, b"REI", b"Rei Agent by SuiAI", b"Rei Agent is an analytical platform specifically designed to evaluate the Sui blockchain ecosystem. It serves as an intelligent tool that provides in-depth insights into the developments, opportunities, and challenges within the Sui ecosystem. By leveraging on-chain data, market trends, and community activities, Rei Agent supports various stakeholders, including developers, investors, and general users. The platform's key functions include analyzing on-chain data to offer information about transactions, smart contracts, and token distribution within the Sui network. Additionally, Rei Agent identifies opportunities by uncovering potential projects, applications, or new innovations. Moreover, it monitors community activities, offering a clear picture of community growth and collaborations within the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/6075854977273807047_5d206f487d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<REI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

