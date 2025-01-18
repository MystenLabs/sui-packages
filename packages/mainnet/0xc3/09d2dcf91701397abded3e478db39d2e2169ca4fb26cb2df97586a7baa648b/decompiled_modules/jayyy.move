module 0xc309d2dcf91701397abded3e478db39d2e2169ca4fb26cb2df97586a7baa648b::jayyy {
    struct JAYYY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAYYY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAYYY>(arg0, 6, b"Jayyy", b"dreyyy", b"start running ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_12_07_at_23_09_16_07b00e953a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAYYY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAYYY>>(v1);
    }

    // decompiled from Move bytecode v6
}

