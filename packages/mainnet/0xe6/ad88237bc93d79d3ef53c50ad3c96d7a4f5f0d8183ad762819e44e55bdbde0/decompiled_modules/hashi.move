module 0xe6ad88237bc93d79d3ef53c50ad3c96d7a4f5f0d8183ad762819e44e55bdbde0::hashi {
    struct HASHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HASHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<HASHI>(arg0, 6, 0x1::string::utf8(b"HASHI"), 0x1::string::utf8(b"Hashi Community"), 0x1::string::utf8(b"Community fan token on Sui. Independent of the Hashi protocol, Mysten Labs and Sui Foundation. Not hBTC; not backed by Bitcoin. No claim to protocol revenue, governance rights, or official utility."), 0x1::string::utf8(b""), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<HASHI>(&mut v3, v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<HASHI>>(0x2::coin_registry::finalize<HASHI>(v3, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<HASHI>>(0x2::coin::mint<HASHI>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

