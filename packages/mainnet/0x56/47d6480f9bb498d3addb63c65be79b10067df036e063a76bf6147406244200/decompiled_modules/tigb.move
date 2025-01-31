module 0x5647d6480f9bb498d3addb63c65be79b10067df036e063a76bf6147406244200::tigb {
    struct TIGB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIGB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIGB>(arg0, 6, b"TIGB", b"Tiger Bear on Sui", x"4d656574205469676572204265617220282454494742290a546865204d656d6520436f696e2054686174732048616c66204669657263652c2048616c6620466c756666792c20616e6420313030252057696c64210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/blue_01_258dae5de2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIGB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIGB>>(v1);
    }

    // decompiled from Move bytecode v6
}

