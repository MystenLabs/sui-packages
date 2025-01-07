module 0x31271dcb6a456587121d9fb0fe450a21c5a1b3b04cbe50039108c85b8567200a::mars {
    struct MARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARS>(arg0, 6, b"MARS", b"MARS SUI", b"MARS SUI MARS SUI MARS SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/q7_Zr_F7ri_400x400_c6e8e15a2b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

