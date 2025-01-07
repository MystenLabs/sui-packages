module 0xf69c05cc6da22ffad57794a9c333d5c136cba3794dc875c8d615a2fb028ac459::suimaga {
    struct SUIMAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAGA>(arg0, 6, b"SUIMAGA", b"SUI MAGA", x"57656c636f6d6520746f20535549204d414741210a54686520666972737420204d414741205472756d70206f6e20535549206e6574776f726b2e0a426f726e20746f206d616b65206d656d65636f696e20677265617420616761696e20616e64206272696e6720796f752066696e616e6369616c2066726565646f6d210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Skjermbilde_2024_10_04_kl_21_37_52_60650aee85.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

