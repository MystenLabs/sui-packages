module 0x1ed3a45bc9017f298cc51db76ea13e5bc5616be441d179fcf8d3e5983ae88f53::suison {
    struct SUISON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISON>(arg0, 6, b"SUISON", b"SUI SEASON is BACK", b"Sui Season is an effective, powerful and simple motivator.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_a2a19442d3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISON>>(v1);
    }

    // decompiled from Move bytecode v6
}

