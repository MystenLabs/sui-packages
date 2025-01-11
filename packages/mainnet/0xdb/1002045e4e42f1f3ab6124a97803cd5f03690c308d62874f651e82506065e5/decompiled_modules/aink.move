module 0xdb1002045e4e42f1f3ab6124a97803cd5f03690c308d62874f651e82506065e5::aink {
    struct AINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AINK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AINK>(arg0, 6, b"AInk", b"AInk Agent", b"AInk Ai Agent create a new Meme AI world on Sui Network ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1219_B15_F_D39_C_4_BCA_AE_44_52_B41_D91298_C_38c761ec55.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AINK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AINK>>(v1);
    }

    // decompiled from Move bytecode v6
}

