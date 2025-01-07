module 0x76918105d95b9c45717b15f647384d03c74555ec4e6e3f38853029541ec9ba6::ratasui {
    struct RATASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RATASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RATASUI>(arg0, 6, b"RATASUI", b"RATA SUI", b"RATASUI- Matt Furie's pet rat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Wat_0d77c357b1.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RATASUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RATASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

