module 0xaff2d724ab6ba5d1ab0df8184fccbb68a245ed5df309dcc059490a63bb0589db::rugpull {
    struct RUGPULL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUGPULL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUGPULL>(arg0, 6, b"RUGPULL", b"RUG PULL", b"Dont BUY Crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae_a_2024_09_16_21_25_05_b617cc2c94.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUGPULL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RUGPULL>>(v1);
    }

    // decompiled from Move bytecode v6
}

