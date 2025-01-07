module 0x1f22ce404da99830a29f8b9e0676ab560707a1275f088bacf30540cfcea6d3c8::suimmy {
    struct SUIMMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMMY>(arg0, 6, b"SUIMMY", b"Suimmy", b"sui, where every swim unveils a new heights!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/instant_26_7402c1f06e_dbcb0fc0eb.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

