module 0xc4f07cace9efb89f358c7cafe7ba6f93f7a29f3a30d394b203ab68d2d010154d::mrbeast {
    struct MRBEAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRBEAST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRBEAST>(arg0, 6, b"MrBEAST", b"Mr. BEAST", b"\"THEY ARE NOT AFTER ME, THEY ARE AFTER YOU, I AM JUST STANDING IN THE WAY!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mr_Beast_fa7cf64cfa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRBEAST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MRBEAST>>(v1);
    }

    // decompiled from Move bytecode v6
}

