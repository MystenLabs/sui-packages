module 0xb5d24240b22fc347e37ed23b289d8ae5da95ef796a2ec70d3f223ebd2c8db72d::lp_token {
    struct LP_TOKEN has key {
        id: 0x2::object::UID,
    }

    public fun new(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency<LP_TOKEN>(arg0, 9, 0x1::string::utf8(b"haWAL-WAL vaultLP Cetus"), 0x1::string::utf8(b"haWAL-WAL Cetus Vault LP Token"), 0x1::string::utf8(b"Cetus Vault LP Token, haWAL-WAL"), 0x1::string::utf8(b"https://node1.irys.xyz/T8UCTnbIDT_8PWn04jAPsGD08wzSyryOzVYbYPzVWhw"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LP_TOKEN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<LP_TOKEN>>(0x2::coin_registry::finalize<LP_TOKEN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

