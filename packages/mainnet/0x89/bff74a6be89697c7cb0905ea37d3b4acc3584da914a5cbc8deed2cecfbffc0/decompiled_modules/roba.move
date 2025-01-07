module 0x89bff74a6be89697c7cb0905ea37d3b4acc3584da914a5cbc8deed2cecfbffc0::roba {
    struct ROBA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBA>(arg0, 6, b"ROBA", b"Robotaxi", x"31302e313020200a0a496e73706972656420627920456c6f6e27732023526f626f746178692c207765206172652061206d656d652f7061726f647920636f6d6d756e69747920204e6f7420616666696c6961746564207769746820582c20456c6f6e2c5465736c6120496e632e2020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GY_Og78_KX_0_AEN_an_b072ad19c0.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBA>>(v1);
    }

    // decompiled from Move bytecode v6
}

