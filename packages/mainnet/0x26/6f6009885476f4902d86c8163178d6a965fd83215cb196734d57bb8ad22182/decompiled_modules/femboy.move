module 0x266f6009885476f4902d86c8163178d6a965fd83215cb196734d57bb8ad22182::femboy {
    struct FEMBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEMBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEMBOY>(arg0, 6, b"FEMBOY", b"Femboy", x"46656d626f79f09f9297", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1753024573133.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FEMBOY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEMBOY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

