module 0xed95d4953db5ae0024e51dae546f763337bf4b386f2f177cc4c4bd87ba2e1676::nepsui {
    struct NEPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEPSUI>(arg0, 6, b"NEPSUI", b"Nepsui", b"Meet Nepsui - The egyptian god of Sui. With his ancient powers, he has arrived to pump the market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dise_A_o_sin_t_A_tulo_2_a5da3a554d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEPSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEPSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

