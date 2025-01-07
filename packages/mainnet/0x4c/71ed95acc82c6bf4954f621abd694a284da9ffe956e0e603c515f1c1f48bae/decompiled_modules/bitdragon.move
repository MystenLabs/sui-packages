module 0x4c71ed95acc82c6bf4954f621abd694a284da9ffe956e0e603c515f1c1f48bae::bitdragon {
    struct BITDRAGON has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITDRAGON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITDRAGON>(arg0, 6, b"BITDRAGON", b"Bitcoin Dragon", b"No socials, let the community make dragon fly.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000007605_b7e6c1cd52.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITDRAGON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITDRAGON>>(v1);
    }

    // decompiled from Move bytecode v6
}

