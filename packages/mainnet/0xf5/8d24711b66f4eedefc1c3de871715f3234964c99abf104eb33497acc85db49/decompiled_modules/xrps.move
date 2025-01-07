module 0xf58d24711b66f4eedefc1c3de871715f3234964c99abf104eb33497acc85db49::xrps {
    struct XRPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: XRPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XRPS>(arg0, 6, b"XRPS", b"XRPonSUI", b"Prepare for a seismic shift! Real $XRP is landing on the SUI network, bringing a wave of change and innovation. This is more than just a coin; it's a revolution!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xrp_95ebed70cf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XRPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XRPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

