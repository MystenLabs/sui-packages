module 0xaaed0dc892b3aee91b3cf5ddc6fed56860a129805a1b0ec3c05759fdfce6d9e7::GARB {
    struct GARB has drop {
        dummy_field: bool,
    }

    fun init(arg0: GARB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GARB>(arg0, 9, 0x1::string::utf8(b"GARB"), 0x1::string::utf8(b"Garbanzanator"), 0x1::string::utf8(b"A fixed-supply meme token inspired by the garbanzanator (1M total supply, locked forever after initial mint)"), 0x1::string::utf8(b"https://ichef.bbci.co.uk/ace/standard/976/cpsprodpb/16620/production/_91408619_55df76d5-2245-41c1-8031-07a4da3f313f.jpg"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<GARB>>(0x2::coin_registry::finalize<GARB>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GARB>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARB>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GARB>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

