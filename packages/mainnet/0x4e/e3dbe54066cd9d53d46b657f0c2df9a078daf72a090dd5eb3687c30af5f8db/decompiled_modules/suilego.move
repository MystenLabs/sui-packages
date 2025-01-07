module 0x4ee3dbe54066cd9d53d46b657f0c2df9a078daf72a090dd5eb3687c30af5f8db::suilego {
    struct SUILEGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILEGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILEGO>(arg0, 6, b"suiLEGO", b"blueLEGO", b"building the sui chain with lego fam", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/d65529d08c527083fbdd1ba5f95aadf1_logo_4e3ca1b16c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILEGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILEGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

