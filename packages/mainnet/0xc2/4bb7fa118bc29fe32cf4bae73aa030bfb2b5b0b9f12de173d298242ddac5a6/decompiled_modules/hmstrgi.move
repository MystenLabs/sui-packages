module 0xc24bb7fa118bc29fe32cf4bae73aa030bfb2b5b0b9f12de173d298242ddac5a6::hmstrgi {
    struct HMSTRGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMSTRGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMSTRGI>(arg0, 6, b"HMSTRGI", b"Hamsterghini", x"49742773206c696b65204c616d626f726768696e69202c2062757420706f77657265642062792068616d737465722e0a0a5468697320697320647265616d206f6620616c6c2068616d73746572202c206d61796265207468657920647265616d2061626f7574204c616d626f726768696e6920627574206765742048616d737465726768696e692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_2da05762aa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMSTRGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HMSTRGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

