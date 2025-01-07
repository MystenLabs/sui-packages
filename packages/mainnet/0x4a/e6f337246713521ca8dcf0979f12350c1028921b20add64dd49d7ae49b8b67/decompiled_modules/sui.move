module 0x4ae6f337246713521ca8dcf0979f12350c1028921b20add64dd49d7ae49b8b67::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 6, b"SUI", b"HarryPotterObamaSonic10Inu", b"HarryPotterObamaSonic10Inu is nothing less than an embodiment of the Quest that led to its discovery (with the exception of 10, being the number of spirals that comprise the Tree of Life). If we listen, we can understand that it is a store of value.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2023_05_09_22_01_50_039e8818b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

