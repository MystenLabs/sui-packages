module 0x796994a3c3565fde7a57c7bc67fe592e8c82dfd15e5eba0572829f8cbc02514c::bluepump {
    struct BLUEPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEPUMP>(arg0, 6, b"BLUEPUMP", b"BLUEPump", b"COMMUNITY TAKE OVER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/97b3b9e0_c8a2_4307_a1ad_cb2b375fd5fd_fab948a6d1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

