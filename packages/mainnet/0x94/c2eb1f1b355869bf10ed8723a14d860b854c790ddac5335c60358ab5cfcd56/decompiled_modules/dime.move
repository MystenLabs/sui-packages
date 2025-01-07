module 0x94c2eb1f1b355869bf10ed8723a14d860b854c790ddac5335c60358ab5cfcd56::dime {
    struct DIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIME>(arg0, 9, b"DIME", b"Vivo", b"To the mon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/99275c90-03f2-4d1f-a32e-4dbdd8375a39.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIME>>(v1);
    }

    // decompiled from Move bytecode v6
}

