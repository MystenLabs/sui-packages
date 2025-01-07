module 0xc12823f7fab0382511a8705f1c43e2a925078c27d68dc0f483990a5cddbd3f06::dtremp {
    struct DTREMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTREMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DTREMP>(arg0, 9, b"DTREMP", b"DnaldTremp", b"United States President", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cf9f963e-51f7-42ec-a624-ecc85effa955.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTREMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DTREMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

