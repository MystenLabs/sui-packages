module 0xfc25c64396d3c7a9c927ba59d42830e07d0fea0f4672578000083f4eb72238b0::aquarius {
    struct AQUARIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AQUARIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AQUARIUS>(arg0, 6, b"Aquarius", b"Sui Aquarius", b"Aquarius on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241005_014451_716_aecf26c47b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AQUARIUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AQUARIUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

