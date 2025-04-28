module 0x939f3190355d80bc2bb43fed8e4de581a8761a8495dd29006f4729b0c540e749::suicafe {
    struct SUICAFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICAFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICAFE>(arg0, 6, b"SUICAFE", b"Sui Cafe", b"The hotspot of Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_62_29cde1b484.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICAFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICAFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

