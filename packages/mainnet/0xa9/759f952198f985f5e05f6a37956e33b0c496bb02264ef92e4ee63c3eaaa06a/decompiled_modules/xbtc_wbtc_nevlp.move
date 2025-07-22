module 0xa9759f952198f985f5e05f6a37956e33b0c496bb02264ef92e4ee63c3eaaa06a::xbtc_wbtc_nevlp {
    struct XBTC_WBTC_NEVLP has drop {
        dummy_field: bool,
    }

    fun init(arg0: XBTC_WBTC_NEVLP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XBTC_WBTC_NEVLP>(arg0, 8, b"nevLP-xBTC-wBTC", b"nevLP-xBTC-wBTC", b"nevLP-xBTC-wBTC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://oss.nemoprotocol.com/vaultMmtXbtcWbtc.svg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<XBTC_WBTC_NEVLP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XBTC_WBTC_NEVLP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

