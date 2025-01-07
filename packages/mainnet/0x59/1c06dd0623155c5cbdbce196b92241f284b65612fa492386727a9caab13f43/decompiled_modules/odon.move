module 0x591c06dd0623155c5cbdbce196b92241f284b65612fa492386727a9caab13f43::odon {
    struct ODON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODON>(arg0, 6, b"ODON", b"SuiOdon", b"ODON is the wealth protector on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000352_59d37d4912.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ODON>>(v1);
    }

    // decompiled from Move bytecode v6
}

