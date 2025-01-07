module 0x4ce8f50b40cac5bb148ea2ef1e2bf8cb3f24107f9ecf00bb9af1e8a41eb21cc8::gbet {
    struct GBET has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBET>(arg0, 6, b"GBET", b"GangstaBet", x"4e6578742d67656e206469676974616c20636f6c6c65637469626c652c204d756c74692d636861696e2067616e677374657220436974792c206f6e200a407375696e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/efd337f1_736c_44c5_85c9_b6a0fac5a9e6_logo_152_71e259aa9f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GBET>>(v1);
    }

    // decompiled from Move bytecode v6
}

