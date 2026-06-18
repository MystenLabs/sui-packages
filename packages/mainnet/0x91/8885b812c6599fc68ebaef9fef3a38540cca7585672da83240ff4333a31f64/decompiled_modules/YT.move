module 0x918885b812c6599fc68ebaef9fef3a38540cca7585672da83240ff4333a31f64::YT {
    struct YT has drop {
        dummy_field: bool,
    }

    fun init(arg0: YT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<YT>(arg0, 6, 0x1::string::utf8(b"YT-sSUI"), 0x1::string::utf8(b"YT-sSUI"), 0x1::string::utf8(b"YT token for Jitter Scallop sSUI market expiring 2026-09-16."), 0x1::string::utf8(b"https://raw.githubusercontent.com/sui-foundation/sui-icons/main/sui-icon.svg"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<YT>>(0x2::coin_registry::finalize<YT>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

