module 0x1b6f62bc160793d9bd784e416a4f20a248e7ee3709c111c18f02f727cdb194d4::nail {
    struct NAIL has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAIL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAIL>(arg0, 6, b"NAIL", b"Billionail", b"Nail Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/billionail_1000_7156e2eb20.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAIL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAIL>>(v1);
    }

    // decompiled from Move bytecode v6
}

