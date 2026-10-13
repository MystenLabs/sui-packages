module 0xce2653c73d744ecbead77f21dfdaa0d0ebc72eb9a755475550f1e15093260acb::xaur {
    struct XAUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: XAUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<XAUR>(arg0, 6, 0x1::string::utf8(b"XAUR"), 0x1::string::utf8(b"Xaura Token"), 0x1::string::utf8(b"XAURA platform token. Internal accounting rate: 1 XAUR = 1 USDC. No reserve-backed USD peg is implied."), 0x1::string::utf8(b""), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<XAUR>(&mut v3, v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<XAUR>>(0x2::coin_registry::finalize<XAUR>(v3, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<XAUR>>(0x2::coin::mint<XAUR>(&mut v2, 35000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

