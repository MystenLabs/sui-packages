module 0x6b95518b5d25d9cb51ee3dc6a3bd232e0f46b1e977809f571a03e6ef30848e98::PT {
    struct PT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PT>(arg0, 6, 0x1::string::utf8(b"PT-sSUI"), 0x1::string::utf8(b"PT-sSUI"), 0x1::string::utf8(b"PT token for Jitter Scallop sSUI market expiring 2026-09-16."), 0x1::string::utf8(b"https://raw.githubusercontent.com/sui-foundation/sui-icons/main/sui-icon.svg"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PT>>(0x2::coin_registry::finalize<PT>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

