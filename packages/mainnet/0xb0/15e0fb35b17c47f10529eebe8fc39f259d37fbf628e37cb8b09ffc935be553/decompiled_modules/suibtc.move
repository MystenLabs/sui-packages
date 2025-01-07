module 0xb015e0fb35b17c47f10529eebe8fc39f259d37fbf628e37cb8b09ffc935be553::suibtc {
    struct SUIBTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBTC>(arg0, 6, b"SUIBTC", b"SUI Bitcoin", b"Satoshi redeploys his invention to Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_bitcoin_4096_02e5d35982.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

