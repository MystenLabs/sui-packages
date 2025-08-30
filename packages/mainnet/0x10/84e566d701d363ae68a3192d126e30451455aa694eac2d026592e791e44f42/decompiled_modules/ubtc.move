module 0x1084e566d701d363ae68a3192d126e30451455aa694eac2d026592e791e44f42::ubtc {
    struct UBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: UBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UBTC>(arg0, 9, b"uBTC", b"Ultra BTC", b"This is a receipt token received only upon depositing to Vaults", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.citypng.com/public/uploads/preview/orange-bitcoin-btc-icon-png-701751695055377fplb1soszf.png")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UBTC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UBTC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

