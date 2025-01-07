module 0x62b1e905acdcb33d6db878bba35b4c3a8e061fd731c4aa399a89270083fef991::dang {
    struct DANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DANG>(arg0, 6, b"DANG", b"GUANGDANG", b"SADDEST CATS EVER LIVE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/gd_8e40f63b59.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

