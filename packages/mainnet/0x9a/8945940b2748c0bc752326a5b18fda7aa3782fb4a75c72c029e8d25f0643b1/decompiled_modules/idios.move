module 0x9a8945940b2748c0bc752326a5b18fda7aa3782fb4a75c72c029e8d25f0643b1::idios {
    struct IDIOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: IDIOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IDIOS>(arg0, 6, b"IDIOS", b"Idiocracy on SUI", x"416464696374656420646567656e6572617465206f6e2074686520626c6f636b636861696e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bm_Q_Hl_b2_400x400_d6d60f3946.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IDIOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IDIOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

