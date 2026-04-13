module 0x8fdaa3296d4a2457b1df7f97f615850860467c008b7f1539c28d2bcd9a81dc80::turbos_lp_bsui_dbusdc {
    struct TURBOS_LP_BSUI_DBUSDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOS_LP_BSUI_DBUSDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOS_LP_BSUI_DBUSDC>(arg0, 9, b"TURBOS-LP-BSUI-DBUSDC", b"TURBOS LP BSUI DBUSDC", b"TURBOS LP Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://app.turbos.finance/icon/turboslptoken.svg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOS_LP_BSUI_DBUSDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TURBOS_LP_BSUI_DBUSDC>>(v1);
    }

    // decompiled from Move bytecode v6
}

