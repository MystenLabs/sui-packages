module 0xa4103b2f10101a62b6b7ce0a016999b3e3fc799800170750f82b7a785cb27c6c::bls {
    struct BLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLS>(arg0, 6, b"BLS", b"Bin Laden Squidward", b"Allahu Akbar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/quality_restoration_20250106183114968_f3602e5f2b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

