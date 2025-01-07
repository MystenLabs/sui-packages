module 0xaa584c5ded3af57420b1c109681421af8db58d729e087b7ab8ed50591422431f::duh {
    struct DUH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUH>(arg0, 6, b"DUH", b"DUH SUI", b"i am tired of all the overcomplicated, try-hard things out there.. just duh.duh.duh.duh.duh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_28_17_11_33_5f977818bc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUH>>(v1);
    }

    // decompiled from Move bytecode v6
}

