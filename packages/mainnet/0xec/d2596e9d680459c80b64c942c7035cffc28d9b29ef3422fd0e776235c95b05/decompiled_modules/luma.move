module 0xecd2596e9d680459c80b64c942c7035cffc28d9b29ef3422fd0e776235c95b05::luma {
    struct LUMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUMA>(arg0, 6, b"Luma", b"LumaAI", b" There is an effort made...and there are many stories...but you must weave your first story...here the story begins...we differ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000034918_034d2f4245.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

