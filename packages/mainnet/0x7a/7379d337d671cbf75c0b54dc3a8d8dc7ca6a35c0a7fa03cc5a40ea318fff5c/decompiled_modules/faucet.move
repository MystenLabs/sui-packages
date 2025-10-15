module 0x2f395459b5e1ff053f4333051d0f5f47a324ea12b96b019d236e873ebc7f017f::faucet {
    struct Token has drop {
        dummy_field: bool,
    }

    struct VISION has key {
        id: 0x2::object::UID,
    }

    public fun new_currency(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<VISION>(arg0, 6, 0x1::string::utf8(b"VISION"), 0x1::string::utf8(b"My VISION"), 0x1::string::utf8(b"Standard Unregulated Coin"), 0x1::string::utf8(b"https://example.com/my_coin.png"), arg1);
        let v2 = v1;
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<VISION>>(0x2::coin_registry::finalize<VISION>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VISION>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<VISION>>(0x2::coin::mint<VISION>(&mut v2, 2000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

