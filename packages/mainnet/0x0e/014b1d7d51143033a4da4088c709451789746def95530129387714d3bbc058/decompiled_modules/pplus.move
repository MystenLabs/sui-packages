module 0xe014b1d7d51143033a4da4088c709451789746def95530129387714d3bbc058::pplus {
    struct PPLUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPLUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PPLUS>(arg0, 9, 0x1::string::utf8(b"PPLUS"), 0x1::string::utf8(b"Bitwise Premium+"), 0x1::string::utf8(b"This receipt token represents the shares a user has of the Bitwise Premium+ Vault on Ember Protocol"), 0x1::string::utf8(b"https://cdn.bluefin.io/images/PPLUS.png"), arg1);
        let v2 = v1;
        0x2::transfer::public_transfer<0x2::coin::Coin<PPLUS>>(0x2::coin::mint<PPLUS>(&mut v2, 5000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PPLUS>>(v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PPLUS>>(0x2::coin_registry::finalize<PPLUS>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

