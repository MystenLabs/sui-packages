module 0x2aded11bd82bba2d008209ea8f432b00391df0b7d517ab6d3aa3e4a032b865a::rcdln {
    struct RCDLN has drop {
        dummy_field: bool,
    }

    fun init(arg0: RCDLN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RCDLN>(arg0, 6, b"RCDLN", b"RICH DOLPHIN", b"RICHEST DOLPHIN IN THE OCEAN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_18_18_28_17_2463e93328.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RCDLN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RCDLN>>(v1);
    }

    // decompiled from Move bytecode v6
}

