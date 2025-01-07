module 0xf69ff2b124746c8110f0fc4ead8494e4751e9bb02983f9ac340d94d11c6013fa::supa {
    struct SUPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPA>(arg0, 6, b"SUPA", b"SUISUPA", x"57656c636f6d6520746f205355504120576f726c6421202453555041203d20534f4f4e0a446f20796f75206d6973732074686520636f6f6c2077617665733f2049206669726d6c792062656c696576652074686174205355492077696c6c20637265617465206974200a2453555041206973207769746820696e202353554920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000018130_75882fb402.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

