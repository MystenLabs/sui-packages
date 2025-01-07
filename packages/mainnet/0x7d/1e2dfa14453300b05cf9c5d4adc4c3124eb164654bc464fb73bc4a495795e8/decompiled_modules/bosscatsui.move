module 0x7d1e2dfa14453300b05cf9c5d4adc4c3124eb164654bc464fb73bc4a495795e8::bosscatsui {
    struct BOSSCATSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOSSCATSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOSSCATSUI>(arg0, 6, b"Bosscatsui", b"Boss cat", b"Bsc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000908912_27998ed666.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOSSCATSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOSSCATSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

