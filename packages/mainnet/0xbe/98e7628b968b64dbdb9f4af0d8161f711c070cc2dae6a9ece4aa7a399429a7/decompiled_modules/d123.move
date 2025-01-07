module 0xbe98e7628b968b64dbdb9f4af0d8161f711c070cc2dae6a9ece4aa7a399429a7::d123 {
    struct D123 has drop {
        dummy_field: bool,
    }

    fun init(arg0: D123, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<D123>(arg0, 6, b"D123", b"DDDD", b"ddd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ghoul_c2cde499e0.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<D123>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<D123>>(v1);
    }

    // decompiled from Move bytecode v6
}

