module 0xebd33132beb5e10e0043bed8bc1ec1a275634db1c9325df3e926d5923501e382::peace {
    struct PEACE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEACE>(arg0, 9, b"PEACE", b"Peace", b"The project aims to promote peace and harmony in the world through various initiatives and activities.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d1dd45e6-d157-46e5-9b61-f50b3df87d84.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEACE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEACE>>(v1);
    }

    // decompiled from Move bytecode v6
}

