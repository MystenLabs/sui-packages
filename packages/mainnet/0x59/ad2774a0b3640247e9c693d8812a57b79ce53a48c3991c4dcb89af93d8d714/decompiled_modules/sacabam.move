module 0x59ad2774a0b3640247e9c693d8812a57b79ce53a48c3991c4dcb89af93d8d714::sacabam {
    struct SACABAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SACABAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SACABAM>(arg0, 6, b"SACABAM", b"Sacabam Fun", b"We may not be the largest-cap memecoin, but we're certainly the most entertaining memecoin community ever alive!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241003_004433_d7fee1edf6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SACABAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SACABAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

