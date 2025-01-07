module 0x8f6079c9cdeb3e0b5570cfa05db89fbb9ad92df1e500d053c3d454c1b28afa2a::beluga {
    struct BELUGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELUGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELUGA>(arg0, 6, b"Beluga", b"BelugaOnSui", x"42656c7567614f6e5375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731012749193.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BELUGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELUGA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

