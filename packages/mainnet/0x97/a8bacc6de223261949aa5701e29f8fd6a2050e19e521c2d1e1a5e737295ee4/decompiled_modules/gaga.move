module 0x97a8bacc6de223261949aa5701e29f8fd6a2050e19e521c2d1e1a5e737295ee4::gaga {
    struct GAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAGA>(arg0, 6, b"GaGa", b"GaGaSUI", b"Very crazy GAGA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731005888421.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAGA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

