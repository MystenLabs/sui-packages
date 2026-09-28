module 0xf26fbbbc5068ee167294d47395b1fa80dc9171a7936de2a106570a47b4fef1c8::intern {
    struct INTERN has drop {
        dummy_field: bool,
    }

    fun init(arg0: INTERN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<INTERN>(arg0, 6, 0x1::string::utf8(b"$Intern"), 0x1::string::utf8(b"Toilet Intern"), 0x1::string::utf8(b"Legendary Toilet Intern - He wanted the Job"), 0x1::string::utf8(b"https://i.postimg.cc/W43pYD0y/IMG-4468.jpg"), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INTERN>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<INTERN>>(0x2::coin_registry::finalize<INTERN>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

