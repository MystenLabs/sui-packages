module 0x96417e7e556a0ca7b326e2ba20e1da617c5c1326d8abe32036ca531845307dc1::become_whale {
    struct BECOME_WHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BECOME_WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BECOME_WHALE>(arg0, 0, 0x1::string::utf8(b"BWH"), 0x1::string::utf8(b"Become Whale"), 0x1::string::utf8(b"Fixed supply. No extra mint. Free trading."), 0x1::string::utf8(b""), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<BECOME_WHALE>(&mut v3, v2);
        let v4 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::Coin<BECOME_WHALE>>(0x2::coin::mint<BECOME_WHALE>(&mut v2, 68686868866888886, arg1), v4);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BECOME_WHALE>>(0x2::coin_registry::finalize<BECOME_WHALE>(v3, arg1), v4);
    }

    // decompiled from Move bytecode v6
}

