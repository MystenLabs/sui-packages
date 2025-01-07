module 0x2c85469ecd5a13c73959f3ec66f07eff5f3bae28340084b2c840174b107fb1c2::xrps {
    struct XRPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: XRPS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XRPS>(arg0, 6, b"XRPS", b"XRPonSUI", b"Prepare for a seismic shift! Real $XRP is landing on the SUI network, bringing a wave of change and innovation. This is more than just a coin; it's a revolution! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/xrp_88fa0b8442.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XRPS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XRPS>>(v1);
    }

    // decompiled from Move bytecode v6
}

