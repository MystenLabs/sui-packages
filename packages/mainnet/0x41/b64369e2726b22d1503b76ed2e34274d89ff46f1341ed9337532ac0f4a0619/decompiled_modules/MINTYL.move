module 0x41b64369e2726b22d1503b76ed2e34274d89ff46f1341ed9337532ac0f4a0619::MINTYL {
    struct MINTYL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINTYL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<MINTYL>(arg0, 9, 0x1::string::utf8(b"MINTYL"), 0x1::string::utf8(b"Mintyl"), 0x1::string::utf8(b"Mintyl is a flexible utility token for DeFi applications on the Sui blockchain."), 0x1::string::utf8(b"https://img.cryptorank.io/coins/mint1713523208214.png"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<MINTYL>>(0x2::coin_registry::finalize<MINTYL>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MINTYL>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINTYL>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINTYL>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

