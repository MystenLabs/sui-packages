module 0x8e0e735cd7182484277995b2dce6b4eaa1f83c75c870523af97465161db3967f::hSUI {
    struct HSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HSUI>(arg0, 9, b"hSUI", b"hSUI Coin", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lv.haedal.xyz/Lendvault/lpt/hsui_dc7cae94.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HSUI>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

