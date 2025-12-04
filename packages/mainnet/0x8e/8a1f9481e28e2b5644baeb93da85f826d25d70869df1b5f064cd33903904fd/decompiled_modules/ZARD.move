module 0x8e8a1f9481e28e2b5644baeb93da85f826d25d70869df1b5f064cd33903904fd::ZARD {
    struct ZARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<ZARD>(arg0, 9, 0x1::string::utf8(b"ZARD"), 0x1::string::utf8(b"Charizard"), 0x1::string::utf8(x"5468652069636f6e696320466972652f466c79696e672d7479706520506f6bc3a96d6f6e2e2049747320666965727920627265617468207265616368657320696e6372656469626c652074656d7065726174757265732c2063617061626c65206f66206d656c74696e6720626f756c646572732e205768656e2043686172697a61726420726f6172732c207468652074656d706572617475726520726973657320746f20756e6265617261626c65206c6576656c732e20f09f94a5f09f9089"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<ZARD>>(0x2::coin_registry::finalize<ZARD>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ZARD>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZARD>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZARD>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

