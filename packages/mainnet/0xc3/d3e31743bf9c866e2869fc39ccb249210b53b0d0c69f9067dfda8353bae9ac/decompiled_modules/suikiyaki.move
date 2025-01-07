module 0xc3d3e31743bf9c866e2869fc39ccb249210b53b0d0c69f9067dfda8353bae9ac::suikiyaki {
    struct SUIKIYAKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKIYAKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKIYAKI>(arg0, 6, b"SUIKIYAKI", b"SUIKIYAKICOIN", b"SUI + sukiyaki", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2_E2jov_Bn_400x400_65c14679a6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKIYAKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKIYAKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

