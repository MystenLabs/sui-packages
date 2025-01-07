module 0x267df53dc49bc620cdfcefb5dd7eb2f6dd4878b35d495fff79f008c1c4e8612d::ode {
    struct ODE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODE>(arg0, 9, b"ODE", b"Odge Coin", b"Forget about Doge themed ones", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        let v3 = 0x2::tx_context::sender(arg1);
        0x2::coin::mint_and_transfer<ODE>(&mut v2, 1000000000000, v3, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODE>>(v2, v3);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ODE>>(v1);
    }

    // decompiled from Move bytecode v6
}

