module 0xc9d08f73f0fa6a69bec40c8a468abc547123d724a8ae3c80452ec35dc19a59ef::fin {
    struct FIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIN>(arg0, 6, b"FIN", b"PUMP.FIN", b"The Genesis Event", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PUMP_FIN_24b95bae6f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

