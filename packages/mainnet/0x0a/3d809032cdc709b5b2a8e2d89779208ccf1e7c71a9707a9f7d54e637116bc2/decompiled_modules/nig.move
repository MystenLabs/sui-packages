module 0xa3d809032cdc709b5b2a8e2d89779208ccf1e7c71a9707a9f7d54e637116bc2::nig {
    struct NIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIG>(arg0, 6, b"NIG", b"NIGEL", b"Meet Nigel the black whale! At birth Nigels dad said Ill be back!  Spoiler alert: He dint come back.  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nig_d378bcb966.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

