module 0x348d28ce4e7acd02476baf316fa55f24d0dbd6e29ba3064e25e0a690de4e28f4::carp {
    struct CARP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARP>(arg0, 6, b"CARP", b"CARP SUI", b"carp turns into dragon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ca_afc472ebe7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CARP>>(v1);
    }

    // decompiled from Move bytecode v6
}

