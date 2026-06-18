module 0x4867e16dce133417cd83a4a97da7b9eeee1758f0029fda4678ae24f660420ecd::SY {
    struct SY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<SY>(arg0, 6, 0x1::string::utf8(b"SY-sSUI"), 0x1::string::utf8(b"SY-sSUI"), 0x1::string::utf8(b"SY token for Jitter Scallop sSUI market expiring 2026-09-16."), 0x1::string::utf8(b"https://raw.githubusercontent.com/sui-foundation/sui-icons/main/sui-icon.svg"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<SY>>(0x2::coin_registry::finalize<SY>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

