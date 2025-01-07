module 0x21c75b1ccf22c55250b056b3feaeed2746b2d8b9476431cc225a13d7275096bd::suiantel69 {
    struct SUIANTEL69 has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIANTEL69, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIANTEL69>(arg0, 6, b"SUIANTEL69", b"Suiantel Kore i69", x"3639204d206b656b652c206170204936392d3432303058585820437065657520746f6f20362c363647687a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sem_nome_2024_10_10_T160842_303_d0d972198f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIANTEL69>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIANTEL69>>(v1);
    }

    // decompiled from Move bytecode v6
}

