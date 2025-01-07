module 0x6b751d3c4e8023b429bb1a63cc189535e6d71af24b24be6977a7b0d7d16635fc::otter {
    struct OTTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTTER>(arg0, 6, b"Otter", b"Sui Otter", b"Otter on sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Otter_3bf86626a9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OTTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

