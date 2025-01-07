module 0x4277457c2d7dc1366759bc9af0068106e069b8326f47b50b17e5d65f596bd559::rocky {
    struct ROCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCKY>(arg0, 6, b"ROCKY", b"ROCKY SUI", b"Rockville's top jokester and meme legend. Always rolling with laughs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731162749831.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROCKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

