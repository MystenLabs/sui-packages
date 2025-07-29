module 0x524a6857c7e168548465b1a0fab15ff06875ec30e3d90e25443aa37611b5f334::lbtc_wbtc_nevlp {
    struct LBTC_WBTC_NEVLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LBTC_WBTC_NEVLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LBTC_WBTC_NEVLP>(arg0, 8, b"nevLP-LBTC-wBTC", b"nevLP-LBTC-wBTC", b"nevLP-LBTC-wBTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://oss.nemoprotocol.com/vaultMmtLbtcWbtc.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LBTC_WBTC_NEVLP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LBTC_WBTC_NEVLP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

