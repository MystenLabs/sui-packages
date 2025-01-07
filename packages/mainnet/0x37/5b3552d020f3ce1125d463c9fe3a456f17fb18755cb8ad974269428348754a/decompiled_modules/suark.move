module 0x375b3552d020f3ce1125d463c9fe3a456f17fb18755cb8ad974269428348754a::suark {
    struct SUARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUARK>(arg0, 6, b"SUARK", b"SUARK THE SHARK", b"Suark is coming in hot to the SUI seas and he is about to break all time highs ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUARK_PFP_ced4470f1a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

