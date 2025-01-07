module 0x7f7da4aaa808fe0a37ed2c1926eae6e9ecda9d5797145d13ebd38da2c292ef88::aplm {
    struct APLM has drop {
        dummy_field: bool,
    }

    fun init(arg0: APLM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APLM>(arg0, 9, b"APLM", b"Apolomax", b"token distribution ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ae0945a1-cb57-4591-827e-0fafd6604e59.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APLM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APLM>>(v1);
    }

    // decompiled from Move bytecode v6
}

