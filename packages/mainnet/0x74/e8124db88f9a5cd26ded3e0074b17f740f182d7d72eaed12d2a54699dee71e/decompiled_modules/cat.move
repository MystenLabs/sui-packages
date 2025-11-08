module 0x74e8124db88f9a5cd26ded3e0074b17f740f182d7d72eaed12d2a54699dee71e::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CAT>(arg0, 9, 0x1::string::utf8(b"CAT"), 0x1::string::utf8(b"Sui Cat"), 0x1::string::utf8(b"Cute Sui Cat"), 0x1::string::utf8(b"https://cataas.com/cat"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<CAT>(&mut v3, v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<CAT>>(0x2::coin::mint<CAT>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CAT>>(0x2::coin_registry::finalize<CAT>(v3, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

