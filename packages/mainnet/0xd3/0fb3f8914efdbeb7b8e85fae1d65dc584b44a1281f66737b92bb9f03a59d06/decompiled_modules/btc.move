module 0xd30fb3f8914efdbeb7b8e85fae1d65dc584b44a1281f66737b92bb9f03a59d06::btc {
    struct BTC has key {
        id: 0x2::object::UID,
    }

    public(friend) fun create(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::TreasuryCap<BTC>, 0x2::coin_registry::MetadataCap<BTC>) {
        let (v0, v1) = 0x2::coin_registry::new_currency<BTC>(arg0, 8, 0x1::string::utf8(b"hBTC"), 0x1::string::utf8(b"BTC"), 0x1::string::utf8(b"BTC secured by hashi."), 0x1::string::utf8(b"https://icons.hashi.sui.io/hbtc"), arg1);
        (v1, 0x2::coin_registry::finalize<BTC>(v0, arg1))
    }

    // decompiled from Move bytecode v7
}

