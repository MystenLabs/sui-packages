module 0x803d27393f7ac90a7baaa4b02515c0930093def0854734ad41696a76a9c3b209::vdrop {
    struct VDROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: VDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VDROP>(arg0, 6, b"VDROP", b"DROP", b"Vdrop is NFT Airdrop Platform, enables users to easily craft their exclusive collections and implement dynamic campaign tactics for distributing NFTs.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_03_29_22_15_52_d046b558a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VDROP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VDROP>>(v1);
    }

    // decompiled from Move bytecode v6
}

