module 0xcbb8fe7a30995cb59115fa1a3f774ee5ed5af55d62e9e44e5508e97d1a7b1640::mochiii {
    struct MOCHIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOCHIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOCHIII>(arg0, 6, b"MOCHIII", b"Mochi On Sui", b"The fluffly, squishy and hungry blob living his best life in the Sui universe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730989834890.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOCHIII>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOCHIII>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

