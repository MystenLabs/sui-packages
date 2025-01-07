module 0x3be1a9ea78616ac09cd33713c3030198e4155871f293b6ed658a9561c076a2d4::investur {
    struct INVESTUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: INVESTUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INVESTUR>(arg0, 6, b"INVESTUR", b"I AM INVESTUR", b"I AM THE SMART", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rs_600x600_190913044000_600_Shane_Gillis_LT_091319_Getty_Images_1157500066_52546d6636.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INVESTUR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INVESTUR>>(v1);
    }

    // decompiled from Move bytecode v6
}

