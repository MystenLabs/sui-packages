module 0x29bcd5b1315879e2d42935705662a7f7393b10fa352aea0861c00a5e16ea4a8d::sms {
    struct SMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMS>(arg0, 6, b"SMS", b"Suiper Mario", b"Join Suiper Mario and rise to the top", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5718_861bf241b5.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

