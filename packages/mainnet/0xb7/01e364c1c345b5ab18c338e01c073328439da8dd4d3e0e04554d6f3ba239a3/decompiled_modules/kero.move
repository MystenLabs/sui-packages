module 0xb701e364c1c345b5ab18c338e01c073328439da8dd4d3e0e04554d6f3ba239a3::kero {
    struct KERO has drop {
        dummy_field: bool,
    }

    fun init(arg0: KERO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KERO>(arg0, 6, b"KERO", b"KERO on SUI", x"4a656574657273206e6f7420416c6c6f776564204b45524f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/x_U7_UJZED_400x400_b53f0cbbc0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KERO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KERO>>(v1);
    }

    // decompiled from Move bytecode v6
}

