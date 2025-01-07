module 0xe8c6aaebde8c2cd34bf9d33ab508a5ae7d8f545958f8e9509009d9c5b41f605b::defiant {
    struct DEFIANT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEFIANT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEFIANT>(arg0, 6, b"DeFiant", b"SuiDeFiant", b"Defying the norms but doing so with an adorable, rebellious flair! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/defiant3_dd1359fef7.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEFIANT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEFIANT>>(v1);
    }

    // decompiled from Move bytecode v6
}

