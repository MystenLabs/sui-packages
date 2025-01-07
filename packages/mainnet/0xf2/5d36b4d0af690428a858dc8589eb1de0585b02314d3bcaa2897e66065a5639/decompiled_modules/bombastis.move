module 0xf25d36b4d0af690428a858dc8589eb1de0585b02314d3bcaa2897e66065a5639::bombastis {
    struct BOMBASTIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOMBASTIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOMBASTIS>(arg0, 9, b"BOMBASTIS", b"Numberone", b"Dobel cill", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e7f603e9-ea13-402e-a77f-bea9dcb17fda.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOMBASTIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOMBASTIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

