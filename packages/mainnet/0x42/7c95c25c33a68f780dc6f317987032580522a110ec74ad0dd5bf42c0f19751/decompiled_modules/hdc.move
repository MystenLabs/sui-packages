module 0x427c95c25c33a68f780dc6f317987032580522a110ec74ad0dd5bf42c0f19751::hdc {
    struct HDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: HDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HDC>(arg0, 9, b"HDC", b"Hardcore", b"This is a first fashion designing project bridging the gap between final user and the manufacturer which incubates all cultures ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a66467a5-3d5b-4510-ba15-4c298103040c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

