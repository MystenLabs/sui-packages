module 0x56b169192e30def971328df0b3137658acfd8226859a5d0a7102894b02a76a0::wilson {
    struct WILSON has drop {
        dummy_field: bool,
    }

    fun init(arg0: WILSON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WILSON>(arg0, 6, b"WILSON", b"Wilson The Alligator", b"Wilson the alligator is living his best life on SUI chain!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/wilsonprofil_f2481c79ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WILSON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WILSON>>(v1);
    }

    // decompiled from Move bytecode v6
}

