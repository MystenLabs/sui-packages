module 0x48212255408d3a5363b3548f484543512ecf490165dc56ba34f3fa771bdfd801::wsg {
    struct WSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WSG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<WSG>(arg0, 6, b"WSG", b"WiseGuyOnSui by SuiAI", b"Relauch WISEGUY in SUI AI FUN, Hustle,Loyalty & A WiseGuy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ch_b_M8j_W_400x400_c4c2c34693.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<WSG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WSG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

