module 0x6866e985c88bab1364b033f0adf8950282495141bb1fdffaae4fbe4889e24d43::btcsui {
    struct BTCSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTCSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTCSUI>(arg0, 6, b"BTCSUI", b"BTSUI", b"The REAL BTC on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_4_b9c98ff585.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTCSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BTCSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

