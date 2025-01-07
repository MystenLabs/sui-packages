module 0x526b65f69b44ef30ba00ae81653675eb77bcaf7067ee91b5bb430128579171be::barry {
    struct BARRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BARRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BARRY>(arg0, 6, b"Barry", b"Flash", b"The fastest token in Turbos", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730976421166.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BARRY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BARRY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

