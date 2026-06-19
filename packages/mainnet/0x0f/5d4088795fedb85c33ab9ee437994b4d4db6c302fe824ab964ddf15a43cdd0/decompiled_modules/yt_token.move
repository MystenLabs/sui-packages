module 0xf5d4088795fedb85c33ab9ee437994b4d4db6c302fe824ab964ddf15a43cdd0::yt_token {
    struct YT_TOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: YT_TOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<YT_TOKEN>(arg0, 9, 0x1::string::utf8(b"YT-sSUI-20260917"), 0x1::string::utf8(b"Nemo YT-Coin sSUI 2026-09-17"), 0x1::string::utf8(b"Nemo sSUI yield token coin for the market maturing on 2026-09-17 UTC."), 0x1::string::utf8(b"https://nemo.xyz/icon-yt.png"), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<YT_TOKEN>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YT_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

