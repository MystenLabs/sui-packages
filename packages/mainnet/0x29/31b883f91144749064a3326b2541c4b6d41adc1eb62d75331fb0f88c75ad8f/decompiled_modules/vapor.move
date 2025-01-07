module 0x2931b883f91144749064a3326b2541c4b6d41adc1eb62d75331fb0f88c75ad8f::vapor {
    struct VAPOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: VAPOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VAPOR>(arg0, 6, b"VAPOR", b"VAPORWARE", b"Nothing but $VAPOR", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c_Yl_Iu_MY_400x400_b25eea452f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VAPOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VAPOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

