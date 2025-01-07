module 0xaa4c09ea7cb2f0513cf55cdc11aab038b962117e0b6b26e19fceb0b13bd925f0::freehop {
    struct FREEHOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: FREEHOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FREEHOP>(arg0, 6, b"FREEHOP", b"Free Hop", b"#FREEHOP we need hop.fun to get launched ASAP.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_0846ff3619.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FREEHOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FREEHOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

