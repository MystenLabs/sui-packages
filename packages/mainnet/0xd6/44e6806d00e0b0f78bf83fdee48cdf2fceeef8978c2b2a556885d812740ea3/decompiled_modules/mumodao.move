module 0xd644e6806d00e0b0f78bf83fdee48cdf2fceeef8978c2b2a556885d812740ea3::mumodao {
    struct MUMODAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUMODAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUMODAO>(arg0, 9, b"MUMODAO", b"Mumo", b"Sumo's favourite mumo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7b4924ea-5912-4c91-92a7-f67c9e7ffcc7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUMODAO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUMODAO>>(v1);
    }

    // decompiled from Move bytecode v6
}

