module 0x22e77563908509daeac22ddfe1a0b7fbcbfa7a60fbe9bfa280788c31c0f21ce3::bpanther {
    struct BPANTHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPANTHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPANTHER>(arg0, 6, b"Bpanther", b"Blue Panther", b"@bluepanthersui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dfgdfgdfg_809045b089.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPANTHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPANTHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

