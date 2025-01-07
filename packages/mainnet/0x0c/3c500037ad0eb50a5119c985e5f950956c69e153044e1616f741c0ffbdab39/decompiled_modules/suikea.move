module 0xc3c500037ad0eb50a5119c985e5f950956c69e153044e1616f741c0ffbdab39::suikea {
    struct SUIKEA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKEA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKEA>(arg0, 6, b"SUIKEA", b"suikea", b"SUIKEA Store will provide all of u want.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suikea_5a9fbacd2b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKEA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKEA>>(v1);
    }

    // decompiled from Move bytecode v6
}

