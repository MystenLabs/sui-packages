module 0xd204542d45a7397db30643e0c28ebade231f4c4f9d3a4d55aa76143511bfeb6::DIGI {
    struct DIGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<DIGI>(arg0, 9, 0x1::string::utf8(b"DIGI"), 0x1::string::utf8(b"DigiEvo Token"), 0x1::string::utf8(b"DigiEvo Token: Evolve your Sui portfolio with digital monster-inspired power! Inspired by the world of Digimon, this token fuels blockchain adventures and community quests on the Sui network."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<DIGI>>(0x2::coin_registry::finalize<DIGI>(v0, arg1), 0x2::tx_context::sender(arg1));
        if (0 == 1) {
            0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DIGI>>(v1);
        } else if (0 == 2) {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIGI>>(v1, @0x0);
        } else {
            0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIGI>>(v1, 0x2::tx_context::sender(arg1));
        };
    }

    // decompiled from Move bytecode v6
}

