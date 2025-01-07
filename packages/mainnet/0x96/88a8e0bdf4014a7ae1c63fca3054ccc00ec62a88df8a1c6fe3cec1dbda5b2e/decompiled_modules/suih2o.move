module 0x9688a8e0bdf4014a7ae1c63fca3054ccc00ec62a88df8a1c6fe3cec1dbda5b2e::suih2o {
    struct SUIH2O has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIH2O, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIH2O>(arg0, 6, b"SUIH2O", b"H2O SUI", x"4669727374204465536369206d656d65206f6e20537569204e6574776f726b210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jew_EUD_Vv_400x400_0344cf4fd0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIH2O>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIH2O>>(v1);
    }

    // decompiled from Move bytecode v6
}

