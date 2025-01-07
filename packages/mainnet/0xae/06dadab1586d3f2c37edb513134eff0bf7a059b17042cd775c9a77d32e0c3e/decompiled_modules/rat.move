module 0xae06dadab1586d3f2c37edb513134eff0bf7a059b17042cd775c9a77d32e0c3e::rat {
    struct RAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAT>(arg0, 6, b"RAT", b"Rat Bastard", b"The Rat Bastard of New York", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/rattt_4a12070ef7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

