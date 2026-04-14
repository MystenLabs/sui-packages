module 0xc75809cf9cc31e93168b983b545314b79a688aeb07adbc6c24b90fb0aa5b74f::turbos_lp_bsui_busdc {
    struct TURBOS_LP_BSUI_BUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOS_LP_BSUI_BUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOS_LP_BSUI_BUSDC>(arg0, 9, b"TURBOS-LP-BSUI-BUSDC", b"TURBOS LP BSUI BUSDC", b"TURBOS LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.turbos.finance/icon/turboslptoken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOS_LP_BSUI_BUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURBOS_LP_BSUI_BUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

