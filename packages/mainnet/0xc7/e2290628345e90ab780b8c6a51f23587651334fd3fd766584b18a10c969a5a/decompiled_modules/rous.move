module 0xc7e2290628345e90ab780b8c6a51f23587651334fd3fd766584b18a10c969a5a::rous {
    struct ROUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROUS>(arg0, 6, b"ROUS", b"ROUNDY ON SUI", b"Roundy is a close friend of a young developer. Together, they create exciting projects on the Sui platform, bringing new values to the community.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_fc77ec5a17.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

