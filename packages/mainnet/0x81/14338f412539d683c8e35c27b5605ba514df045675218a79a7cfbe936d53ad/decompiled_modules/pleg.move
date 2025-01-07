module 0x8114338f412539d683c8e35c27b5605ba514df045675218a79a7cfbe936d53ad::pleg {
    struct PLEG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLEG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLEG>(arg0, 6, b"PLEG", b"Pure Legitness", b"Pure Legitness ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dqa_X_Ya_Hz_400x400_b09e242bdb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLEG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLEG>>(v1);
    }

    // decompiled from Move bytecode v6
}

