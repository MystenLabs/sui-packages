module 0x435c3788490c16fe09eaf84c1de972b1d4b64dc09c1d50eb8907d3ec79451392::cat {
    struct CAT has key {
        id: 0x2::object::UID,
    }

    public fun new_currency(arg0: &0x2::package::UpgradeCap, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<CAT>(arg1, 9, 0x1::string::utf8(b"CAT"), 0x1::string::utf8(b"Sui Cat"), 0x1::string::utf8(b"Cute Sui Cat"), 0x1::string::utf8(b"https://iili.io/KDZoIR9.md.jpg"), arg2);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<CAT>(&mut v3, v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CAT>>(0x2::coin_registry::finalize<CAT>(v3, arg2), 0x2::tx_context::sender(arg2));
        0x2::transfer::public_transfer<0x2::coin::Coin<CAT>>(0x2::coin::mint<CAT>(&mut v2, 1000000000000000000, arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

