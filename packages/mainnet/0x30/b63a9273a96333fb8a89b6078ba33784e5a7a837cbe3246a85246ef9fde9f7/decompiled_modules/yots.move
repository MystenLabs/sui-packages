module 0x30b63a9273a96333fb8a89b6078ba33784e5a7a837cbe3246a85246ef9fde9f7::yots {
    struct YOTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOTS>(arg0, 6, b"YOTS", b"Year of the Snake 2025", b"Year of the Snake ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_4b0974c16a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

