module 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::sti {
    struct STI has drop {
        dummy_field: bool,
    }

    fun init(arg0: STI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STI>(arg0, 9, b"STI", b"Sui Trenches Index", b"A redeemable on-chain basket of the Sui trenches, governed by its holders.", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STI>>(v1);
        let (v2, v3, v4) = 0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::create<STI>(v0, arg1);
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::AdminCap>(v2, v5);
        0x2::transfer::public_transfer<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::GuardianCap>(v3, v5);
        0x2::transfer::public_transfer<0x54e8315e419c9768faf889e36a0a12c90287e14669903f20f92f0ce9a8013c2::index::KeeperCap>(v4, v5);
    }

    // decompiled from Move bytecode v7
}

