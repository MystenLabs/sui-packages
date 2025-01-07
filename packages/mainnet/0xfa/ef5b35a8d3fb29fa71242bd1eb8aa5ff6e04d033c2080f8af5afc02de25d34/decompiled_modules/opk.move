module 0xfaef5b35a8d3fb29fa71242bd1eb8aa5ff6e04d033c2080f8af5afc02de25d34::opk {
    struct OPK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPK>(arg0, 6, b"OPK", b"Obi PNut Kenobi", b"If you strike me down, I will become more powerful than you could possibly imagine Obi PNut Kenobi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/001_fc9d53cb13.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OPK>>(v1);
    }

    // decompiled from Move bytecode v6
}

