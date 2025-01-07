module 0x745a8f2eb6da65dac38838944705f067525a922dbf13c73288d19bcab5f87c4b::asa {
    struct ASA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ASA>(arg0, 6, b"Asa", b"Asainsui", b"dasdaasdasdasasddasdasdasdasdasdasdasd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Z_Di_Tl_ae_400x400_removebg_preview_50466d0470.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASA>>(v1);
    }

    // decompiled from Move bytecode v6
}

