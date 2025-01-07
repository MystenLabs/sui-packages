module 0xc28de5c0efc3bab9ae98de812483c5f97ddbd1ec417349d8ef34bba09ba3c95::varc {
    struct VARC has drop {
        dummy_field: bool,
    }

    fun init(arg0: VARC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VARC>(arg0, 6, b"Varc", b"Villian ARC", b"You underestimate my power!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dw_f1669a4f11.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VARC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VARC>>(v1);
    }

    // decompiled from Move bytecode v6
}

