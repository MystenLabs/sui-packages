module 0x3c8f79dfc5076cdfc4c5b7c166414dd7488e73a62c006387c5835c6c2950664d::bloo {
    struct BLOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOO>(arg0, 6, b"BLOO", b"BLOO DENG", b"The Blue Moo Deng", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bloo_265ee4142b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

