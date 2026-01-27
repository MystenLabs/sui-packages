module 0x71d2f18028e597337c8b4dd0e4c199c3d92761beda37a77694517f0f68ae2ab9::usdg {
    struct USDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<USDG>(arg0, 9, 0x1::string::utf8(b"USDG"), 0x1::string::utf8(b"USDG"), 0x1::string::utf8(b"USDG"), 0x1::string::utf8(b"no link"), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<USDG>>(0x2::coin_registry::finalize<USDG>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::TreasuryCap<USDG>>(v1);
    }

    public fun register(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: 0x2::transfer::Receiving<0x2::coin_registry::Currency<USDG>>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin_registry::finalize_registration<USDG>(arg0, arg1, arg2);
    }

    // decompiled from Move bytecode v6
}

