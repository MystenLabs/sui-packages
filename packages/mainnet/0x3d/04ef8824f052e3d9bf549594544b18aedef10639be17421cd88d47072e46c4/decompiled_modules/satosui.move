module 0x3d04ef8824f052e3d9bf549594544b18aedef10639be17421cd88d47072e46c4::satosui {
    struct SATOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SATOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SATOSUI>(arg0, 6, b"SATOSUI", b"Satosui Nakamoto", b"The mysterious father of blockchain and cryptocurrency has arrived on the Sui Network, sparking a new wave of excitement in the community. This arrival is expected to usher in a new era of transparency and security.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_29_13_11_58_39f3b97143.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SATOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SATOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

