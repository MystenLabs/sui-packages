module 0xef0cb9a0c35b91eca1adb1514d5376c6ded1166a9cb5f99216431f6ca203e04::suigltch {
    struct SUIGLTCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGLTCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGLTCH>(arg0, 6, b"SuiGltch", b"SuiGl!tch", b"SuiGl!tch is a revolutionary meme token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732080508237.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIGLTCH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGLTCH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

