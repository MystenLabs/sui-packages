module 0x9e9b612951331910137afbe47c44998be010983f3ad532fd11fc6c0c5c36bfbe::dud {
    struct DUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUD>(arg0, 6, b"DUD", b"Hop aggravator", b"Just reload it and it will work never!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8877_83a8b3c480.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

