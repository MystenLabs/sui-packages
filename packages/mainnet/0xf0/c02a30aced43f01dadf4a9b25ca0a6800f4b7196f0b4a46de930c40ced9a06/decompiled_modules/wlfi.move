module 0xf0c02a30aced43f01dadf4a9b25ca0a6800f4b7196f0b4a46de930c40ced9a06::wlfi {
    struct WLFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WLFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WLFI>(arg0, 6, b"WLFI", b"World Liberty Financial", b"We are launching $WLFI (World Liberty Financial, Inc.), a powerful global decentralized finance (\" DeFi \") protocol designed to bring permissionless peer-to-peer digital asset systems to everyone. WLFi also launched the WLFi Governance Platform, a DeFi governance platform governance for $WLFI token holders that aims to help shape the WLFi protocol through governance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/670c86cd038a62c39d19e598_1728874190_597d475f26.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WLFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WLFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

