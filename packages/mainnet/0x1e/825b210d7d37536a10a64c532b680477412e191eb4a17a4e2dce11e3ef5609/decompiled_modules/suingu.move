module 0x1e825b210d7d37536a10a64c532b680477412e191eb4a17a4e2dce11e3ef5609::suingu {
    struct SUINGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINGU>(arg0, 6, b"SUINGU", b"Suingu", b"NHEK NHEK! suingu.online", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suingu_61d963001d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINGU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINGU>>(v1);
    }

    // decompiled from Move bytecode v6
}

