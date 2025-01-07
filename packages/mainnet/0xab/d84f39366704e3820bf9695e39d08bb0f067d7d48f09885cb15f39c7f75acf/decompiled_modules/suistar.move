module 0xabd84f39366704e3820bf9695e39d08bb0f067d7d48f09885cb15f39c7f75acf::suistar {
    struct SUISTAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISTAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISTAR>(arg0, 6, b"Suistar", b"Suistarfish", b"Suistarfish is a mystical sea creature that lives in distant, vibrant oceans. Known for its shimmering, star-like appearance, it has five colorful arms that emit different hues, attracting marine life.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0_2_8de6caf2e2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISTAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISTAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

