module 0xf0e723c1db5e1c09452d36f68b1a2b044fee0b752128851bd3417c28cd2e8302::froginblack {
    struct FROGINBLACK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROGINBLACK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROGINBLACK>(arg0, 6, b"FROGINBLACK", b"FROGS IN BLACK", b"We are a boat...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8b205d2270dd15cf961a422a1c068a2f_1_89801b4d7b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROGINBLACK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROGINBLACK>>(v1);
    }

    // decompiled from Move bytecode v6
}

