module 0xfaacff9bd217132a697240197419bd6835895ec9b4994b77fe075703c2c556cb::dpump {
    struct DPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: DPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DPUMP>(arg0, 6, b"DPUMP", b"Donald PUMP", b"THE 47TH PRESIDENT OF THE UNITED STATES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/45_donald_trump_a2e806d2ef.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

