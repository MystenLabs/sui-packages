module 0x2d13a8e1f2fa000bf1762635da6beee22bb7414fcfc99909bbc20e358014f046::skurtsui {
    struct SKURTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKURTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKURTSUI>(arg0, 6, b"SKURTSUI", b"SKURTURTLE", b"A cute and badass turtle shredding its way through SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_12_025240066_5d85e05498.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKURTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKURTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

