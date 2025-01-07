module 0xcab93cbfd69f99aacb8e270a342fe52c63d61a7c9a3f0bc9c83318d52de3c001::mash {
    struct MASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<MASH>(arg0, 9, b"Mashup", b"MASH", b"Mashup is designed to reward and empower our members, bringing together NFTs and tokenomics for everyone. Collect, trade, and earn while being part of something special.", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<MASH>(&mut v3, 15000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<MASH>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MASH>>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MASH>>(v2);
    }

    // decompiled from Move bytecode v6
}

