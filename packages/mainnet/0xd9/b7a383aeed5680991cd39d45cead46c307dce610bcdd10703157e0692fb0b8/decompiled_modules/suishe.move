module 0xd9b7a383aeed5680991cd39d45cead46c307dce610bcdd10703157e0692fb0b8::suishe {
    struct SUISHE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHE>(arg0, 6, b"SUISHE", b"Suishe", b"First pure breed Suishe Husky", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_4_08021dc64a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHE>>(v1);
    }

    // decompiled from Move bytecode v6
}

