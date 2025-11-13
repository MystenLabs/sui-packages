module 0x3cd711c02597eba9e20f04cb8eee214c23229605faaaa717eafbbbdee55ccfb::lineup {
    struct LINEUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LINEUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<LINEUP>(arg0, 9, 0x1::string::utf8(b"LINEUP"), 0x1::string::utf8(b"Lineup Token"), 0x1::string::utf8(b"LINEUP is the premium, cross-game loyalty and progression layer of the Lineup Network."), 0x1::string::utf8(b"https://ipfs.io/ipns/k51qzi5uqu5djrmc9nlacs9w7jaal8gcinrmjriz51nyjdu346x77nmqat73jv"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<LINEUP>(&mut v3, v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<LINEUP>>(0x2::coin_registry::finalize<LINEUP>(v3, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<LINEUP>>(0x2::coin::mint<LINEUP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

