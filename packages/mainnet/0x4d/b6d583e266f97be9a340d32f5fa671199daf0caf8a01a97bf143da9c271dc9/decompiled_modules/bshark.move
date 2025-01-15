module 0x4db6d583e266f97be9a340d32f5fa671199daf0caf8a01a97bf143da9c271dc9::bshark {
    struct BSHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSHARK>(arg0, 6, b"BSHARK", b"Bullshark", x"4d65657420746865206661737465737420637265617475726520696e2074686520736561efbc81f09f9a8020416476616e63656420536e6970657220426f74202b20f09fa496204149204167656e74202b20f09f96bc2044796e616d696320504650204e465473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736953179675.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSHARK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSHARK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

