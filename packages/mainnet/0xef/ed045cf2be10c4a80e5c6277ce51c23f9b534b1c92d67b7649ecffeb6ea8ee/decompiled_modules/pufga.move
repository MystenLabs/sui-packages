module 0xefed045cf2be10c4a80e5c6277ce51c23f9b534b1c92d67b7649ecffeb6ea8ee::pufga {
    struct PUFGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFGA>(arg0, 6, b"PUFGA", b"Puffy Nigga", b"Making waves and catching rays", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_170720_a401d5b231.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

