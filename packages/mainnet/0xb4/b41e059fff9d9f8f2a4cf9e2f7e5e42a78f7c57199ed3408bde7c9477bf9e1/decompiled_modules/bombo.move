module 0xb4b41e059fff9d9f8f2a4cf9e2f7e5e42a78f7c57199ed3408bde7c9477bf9e1::bombo {
    struct BOMBO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOMBO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOMBO>(arg0, 6, b"BOMBO", b"BomboClat Sui", b"$BOMBO on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000385_293611536d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOMBO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOMBO>>(v1);
    }

    // decompiled from Move bytecode v6
}

