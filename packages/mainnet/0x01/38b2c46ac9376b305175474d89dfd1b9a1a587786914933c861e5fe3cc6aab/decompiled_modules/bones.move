module 0x138b2c46ac9376b305175474d89dfd1b9a1a587786914933c861e5fe3cc6aab::bones {
    struct BONES has key {
        id: 0x2::object::UID,
    }

    public fun new_currency(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<BONES> {
        assert!(0x2::tx_context::sender(arg1) == @0x9728ec13d7321c7ee46669454e6d49857cc29fed09ba13696af7692c55e61a24, 1);
        let (v0, v1) = 0x2::coin_registry::new_currency<BONES>(arg0, 0, 0x1::string::utf8(b"BONES"), 0x1::string::utf8(b"BONES"), 0x1::string::utf8(b"Bones"), 0x1::string::utf8(b"https://walrus.doonies.net/bones.png"), arg1);
        let v2 = v1;
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BONES>>(0x2::coin_registry::finalize<BONES>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONES>>(v2, 0x2::tx_context::sender(arg1));
        0x2::coin::mint<BONES>(&mut v2, 1000000000, arg1)
    }

    // decompiled from Move bytecode v6
}

