module 0xf7f03754e2fb04696e44af37a470569ca077894a5229ee51473ba640341eabf8::slug {
    struct SLUG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SLUG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SLUG>(arg0, 6, b"SLUG", b"SLUG SUI", b"THE PATRON SAINT OF SUI DEGENS. HE MAY BE MADE OF GARBAGE AND FILTH, BUT HIS HEART IS PURE AND UNCORRUPTED!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_f4d0469c65.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SLUG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SLUG>>(v1);
    }

    // decompiled from Move bytecode v6
}

