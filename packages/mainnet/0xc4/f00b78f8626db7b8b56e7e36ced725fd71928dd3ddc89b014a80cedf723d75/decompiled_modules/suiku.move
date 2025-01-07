module 0xc4f00b78f8626db7b8b56e7e36ced725fd71928dd3ddc89b014a80cedf723d75::suiku {
    struct SUIKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKU>(arg0, 6, b"SUIKU", b"SUIKU on SUI", b"Akira Toriyama!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/di_RC_Aw_Z4_400x400_b3c09f673e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

