module 0x7561e3ce9e7e3c4565fc4401f79df2ec9056b2262dc3a82596fffa090fd02a8d::mrc {
    struct MRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRC>(arg0, 6, b"MRC", b"Million Roars coin", b"Welcome to MILLION ROARS COIN! Step into the wild world of MRC!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022444_b92a246cc2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRC>>(v1);
    }

    // decompiled from Move bytecode v6
}

