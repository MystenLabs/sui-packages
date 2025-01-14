module 0x33341855ce5aea370d26a85d7d93fdd84160e475a03dffa4bdac5ac64019ad9c::vio {
    struct VIO has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<VIO>(arg0, 6, b"VIO", b"Vio AI by SuiAI", b"AI AGENT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/lg_e008aa5b01.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VIO>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIO>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

