module 0x8e065a55b5980c14ad5f0ff36c10f03655dc170c5eaf160ea164260a751d3087::breadsui {
    struct BREADSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREADSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BREADSUI>(arg0, 6, b"BREADSUI", b"Bread SUI AI Agent", b"Bread SUI AI Agent.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1kr_A1h_Xu_400x400_7ed9044bf8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREADSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BREADSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

