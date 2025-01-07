module 0x973065d7c8b1bc36743f0422141b69073412b82bf814a0388acf51ddb2e24de3::botak {
    struct BOTAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOTAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOTAK>(arg0, 9, b"BOTAK", b"Botaks", b"Botak gundul plontos tak ada rambut", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/11624081-ddc0-480a-8122-e528c2cf33da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOTAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOTAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

