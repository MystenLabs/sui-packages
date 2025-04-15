module 0xcb7135353ed85eb1167a69c743b296df4825487441ff138c8bd4ae835a4aa3dd::shro {
    struct SHRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRO>(arg0, 6, b"SHRO", b"SHRO Token", b"SroomAI DAO - the first AI hedge fund for AI projects investment on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreie556jewytizvz47jzizpsndiyw7ihqza3edrjw2mkwv6vhaq5n4e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SHRO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

