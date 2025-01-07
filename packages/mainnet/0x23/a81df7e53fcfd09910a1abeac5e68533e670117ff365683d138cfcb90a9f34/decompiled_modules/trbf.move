module 0x23a81df7e53fcfd09910a1abeac5e68533e670117ff365683d138cfcb90a9f34::trbf {
    struct TRBF has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRBF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRBF>(arg0, 6, b"TRBF", b"TURBO FROG", b"First Frog on Turbo Fun ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731001512304.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRBF>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRBF>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

