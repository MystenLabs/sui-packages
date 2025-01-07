module 0xcd9fd084bb98151b2b60057c64bbaf2372c181cdcb0afa43e95e38d420af55e3::pie {
    struct PIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIE>(arg0, 9, b"PIE", b"SuiPie", b"SuiPie is a fun, efficient token on the Sui blockchain, delivering fast transactions and low fees. With its playful name, SuiPie offers a simple and rewarding experience for users, making it a tasty choice in the Sui ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/971905807024504833/u77rPWno.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PIE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

