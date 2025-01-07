module 0x83648a54e1972b7c7008a3105f0e59c2bc3dfdeb9e268a66bf3a2b3f9acb7654::prump {
    struct PRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRUMP>(arg0, 6, b"PRUMP", b"PRUMP it - SEND it - MOVE it", x"5052554d50206861732050554d50206973206974206f6e6c792069662063616e207365652069742057696e6b2057696e6b2e200a5465616d2068617320736f6d652042696720706c616e7320666f72205052554d502e200a5052554d5020697320796f757220507265736964656e74202d204c657473206861766520612046756e2077697468205052554d502e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/prump_dffa03291f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

