module 0xcb2cc06aca19fbf844f03c97fca8ac7deb40388deec52425d40240c6b9c1f5ce::suai {
    struct SUAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUAI>(arg0, 6, b"SUAI", b"SUIAI", b"SuiAI.fun is a launchpad for autonomous AI agents built on the Sui blockchain. It serves as a central platform that allows creators to deploy AI agents on-chain in just seconds. The platform provides users with the ability to discover, co-own, and interact with these agents, supporting the growth of AI applications and promoting a more accessible and collaborative environment within the ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suag_logo_e1cd1bb8de.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

