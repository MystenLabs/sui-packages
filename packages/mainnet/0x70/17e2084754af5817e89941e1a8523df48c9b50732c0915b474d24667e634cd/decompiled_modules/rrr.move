module 0x7017e2084754af5817e89941e1a8523df48c9b50732c0915b474d24667e634cd::rrr {
    struct RRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RRR>(arg0, 6, b"rrr", x"c6b06572", b"r", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/47b4f8e4-a0ce-4a87-b3e5-81b2448209fa.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RRR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RRR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

