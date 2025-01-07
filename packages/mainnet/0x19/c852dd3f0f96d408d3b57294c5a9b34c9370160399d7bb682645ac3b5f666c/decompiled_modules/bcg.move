module 0x19c852dd3f0f96d408d3b57294c5a9b34c9370160399d7bb682645ac3b5f666c::bcg {
    struct BCG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BCG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BCG>(arg0, 6, b"BCG", b"GenmaFrog", b"Better Call Genma", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/genmafrog_e0f7cbfa90.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BCG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BCG>>(v1);
    }

    // decompiled from Move bytecode v6
}

