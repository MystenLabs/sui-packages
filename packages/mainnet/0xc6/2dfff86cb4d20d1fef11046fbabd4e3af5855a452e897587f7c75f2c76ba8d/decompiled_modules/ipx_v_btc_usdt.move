module 0xc62dfff86cb4d20d1fef11046fbabd4e3af5855a452e897587f7c75f2c76ba8d::ipx_v_btc_usdt {
    struct IPX_V_BTC_USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: IPX_V_BTC_USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IPX_V_BTC_USDT>(arg0, 9, b"ipx-v-btc-usdt", b"BTC/USDT", b"CLAMM Interest Protocol LpCoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.interestprotocol.com/")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IPX_V_BTC_USDT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IPX_V_BTC_USDT>>(v1);
    }

    // decompiled from Move bytecode v6
}

