module 0x8a15e51cc484b4d09955aca5b019750cf03fb60095013a7c57c9aec4d7cf8ce2::zorp {
    struct ZORP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZORP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZORP>(arg0, 6, b"ZORP", b"Zorp is Famous", b"Zorp is famous", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fv4_Sz23_SA_8tysoryzym7_Nnq4h_D_Rhw_XCQ_Be_Ud_V95tpump_a90da1bc48.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZORP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZORP>>(v1);
    }

    // decompiled from Move bytecode v6
}

