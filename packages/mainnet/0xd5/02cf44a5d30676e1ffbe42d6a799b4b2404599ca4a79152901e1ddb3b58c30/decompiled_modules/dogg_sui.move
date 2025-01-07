module 0xd502cf44a5d30676e1ffbe42d6a799b4b2404599ca4a79152901e1ddb3b58c30::dogg_sui {
    struct DOGG_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGG_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGG_SUI>(arg0, 9, b"DOGG_SUI", b"DOGS", b"Dogs on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ae2e8015-0b2d-4de0-b445-2304d9d4ba45.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGG_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGG_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

