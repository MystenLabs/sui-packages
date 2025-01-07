module 0x3f148a1815460b3d7088cc3e532c3b60d9d0aa3e3e1968fafb9c508e1977a7cc::cybervikings {
    struct CYBERVIKINGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYBERVIKINGS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CYBERVIKINGS>(arg0, 6, b"CYBERVIKINGS", b"The First People", b"We Are The First People Of Mars", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/69_Zq_Fj_Ad_400x400_82692ef2ff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYBERVIKINGS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CYBERVIKINGS>>(v1);
    }

    // decompiled from Move bytecode v6
}

