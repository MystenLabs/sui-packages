module 0x54a64ba20284deca7bfb79cb8aeecd95b02a7964c1e2045596c64467507b7cde::oink {
    struct OINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OINK>(arg0, 6, b"OINK", b"Sui Oink", b"$OINK is the most adventurous pig, scuba-diving into SUI Ocean ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000249684_03ced04521.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

