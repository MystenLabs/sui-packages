module 0x410b3e5dadd8c3970e3c438651f65d099852bad908c31379c0364497c220fcfb::harambe {
    struct HARAMBE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARAMBE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HARAMBE>(arg0, 6, b"HARAMBE", b"HARAMBE by SuiAI", x"486172616d626520726570726573656e747320756e6974792c20636f6d70617373696f6e2c206974e280997320612073796d626f6c206f66206368616e67652c206120627269646765206265747765656e20746563686e6f6c6f677920616e6420707572706f73652e20576520686f6e6f722061206d65737361676520746861742074686520776f726c64206d757374206e6576657220666f726765742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/R_Qj_Ty_1_W_400x400_492bf50024.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HARAMBE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARAMBE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

