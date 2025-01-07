module 0x4c0ef467b8f756294be9126a70a2678840b2609bde68006191554dd7b3ee9908::derp {
    struct DERP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DERP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DERP>(arg0, 6, b"DERP", b"Derpman", b"derpa derpa derpa derpa Derpman!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_09_182323_45e29bdf7e_a9fe60ad75.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DERP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DERP>>(v1);
    }

    // decompiled from Move bytecode v6
}

