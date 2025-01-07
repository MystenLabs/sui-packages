module 0x2f40492802a56ec564e2670bbb52e5fe72b9ea92b1cae03e2934e0e38a24cbfe::afsd {
    struct AFSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFSD>(arg0, 6, b"Afsd", b"sdfa", b"dsafas", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_21_00_22_25_b77b773302.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AFSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

