module 0xa35e0444f623975672492f22fcd6f7a8dbe1ebb5ad0c841e991f311de54f9b43::moonlite {
    struct MOONLITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONLITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONLITE>(arg0, 6, b"Moonlite", b"Moonlite Bot", b"Meet Moonlite, The first ever Trading Bot on Sui through telegram. After our first round of beta testing, Rev share will be enabled with holders.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/De_Q_3wf_B_400x400_a620459702.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONLITE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOONLITE>>(v1);
    }

    // decompiled from Move bytecode v6
}

