module 0xf324da20433f940a3f49d668e2f83c458edce57dd1c552a2ddc73e7f4eb13b80::babys {
    struct BABYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYS>(arg0, 9, b"BABYS", b"BabySui", b"Cool token BabySui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ec343ef0-a672-4803-a5a5-de823aeb3829.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABYS>>(v1);
    }

    // decompiled from Move bytecode v6
}

