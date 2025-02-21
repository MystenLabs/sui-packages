module 0x918a026dab039666f9819b5b3f66e426d8a2def47211269226b422a45ee8b740::aig {
    struct AIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIG>(arg0, 6, b"AIG", b"aighost by SuiAI", b"ghosting your AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/istockphoto_1426692001_612x612_766d70fa00.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

