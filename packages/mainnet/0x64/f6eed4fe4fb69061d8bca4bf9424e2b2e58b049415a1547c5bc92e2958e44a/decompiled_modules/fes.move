module 0x64f6eed4fe4fb69061d8bca4bf9424e2b2e58b049415a1547c5bc92e2958e44a::fes {
    struct FES has drop {
        dummy_field: bool,
    }

    fun init(arg0: FES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FES>(arg0, 6, b"FES", b"Furie Eyes Sui", x"467572696573206579657320617265207761746368696e67207468652053756920436861696e2e200a0a546865736520657965732061726520776f7274682062696c6c79732e200a0a4f726967696e616c2061727420616e6420756e69717565207469636b65722e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tak_berjudul66_20250103060420_b90df861cf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FES>>(v1);
    }

    // decompiled from Move bytecode v6
}

