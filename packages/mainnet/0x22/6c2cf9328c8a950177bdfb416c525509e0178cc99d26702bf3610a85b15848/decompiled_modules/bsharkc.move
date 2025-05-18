module 0x226c2cf9328c8a950177bdfb416c525509e0178cc99d26702bf3610a85b15848::bsharkc {
    struct BSHARKC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSHARKC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSHARKC>(arg0, 9, b"BSHARKC", b"BSHARK", x"404d797374656e5f4c6162730a2063686f73652042756c6c736861726b2061732074686520636f6e73656e73757320656e67696e65207468617420706f776572732074686520537569206e6574776f726b2e2057652063686f7365202442534841524b206173206f75722073796d626f6c20666f722063756c7475726520616e6420636f6d6d756e697479206f6e20245355492e204d656d652b5574696c697479", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/bd8ea1b337ab872b89062f7cc5bf04a0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BSHARKC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSHARKC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

