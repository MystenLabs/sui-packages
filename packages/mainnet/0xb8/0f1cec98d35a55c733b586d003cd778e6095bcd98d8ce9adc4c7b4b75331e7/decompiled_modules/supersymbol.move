module 0xb80f1cec98d35a55c733b586d003cd778e6095bcd98d8ce9adc4c7b4b75331e7::supersymbol {
    struct SUPERSYMBOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPERSYMBOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPERSYMBOL>(arg0, 6, b"SUPERSYMBOL", b"SUPERNAME", b"SUPERDESCRIPTION", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N_N_D_D_N_D_N_D_d1b423d435.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPERSYMBOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPERSYMBOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

