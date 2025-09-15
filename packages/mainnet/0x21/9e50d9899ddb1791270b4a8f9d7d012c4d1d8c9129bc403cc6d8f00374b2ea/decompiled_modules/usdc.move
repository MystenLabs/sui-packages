module 0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::usdc {
    struct USDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::upgrade_service::new<USDC>(arg0, 0x2::tx_context::sender(arg1), arg1);
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<USDC>(v1, 6, b"USDC", b"USDC", b"USDC is a US dollar-backed stablecoin issued by Circle. USDC is designed to provide a faster, safer, and more efficient way to send, spend, and exchange money around the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://www.circle.com/hubfs/Brand/USDC/USDC_icon_32x32.png"))), true, arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDC>>(v4);
        0x2::transfer::public_share_object<0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::treasury::Treasury<USDC>>(0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::treasury::new<USDC>(v2, v3, 0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1), 0x2::tx_context::sender(arg1), arg1));
        0x2::transfer::public_share_object<0x219e50d9899ddb1791270b4a8f9d7d012c4d1d8c9129bc403cc6d8f00374b2ea::upgrade_service::UpgradeService<USDC>>(v0);
    }

    // decompiled from Move bytecode v6
}

