module 0xeaff13f3f95446e47d5464c630ac63d2ed58b600e9b27e45bf299fe47c2ec726::rugpullz_r {
    struct RUGPULLZ_R has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUGPULLZ_R, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUGPULLZ_R>(arg0, 9, b"RUGPULLZ_R", b"RugPullz", x"4469766520696e20666f7220746865206c61756768732c207374617920666f722074686520746872696c6c2c20616e642072656d656d6265723a206974e280997320616c6c20696e20676f6f642066756ee28094756e74696c207468652072756720676574732070756c6c656421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/09dfd508-9a7b-4bae-8da4-37183467a1c6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUGPULLZ_R>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUGPULLZ_R>>(v1);
    }

    // decompiled from Move bytecode v6
}

