module 0xfb58f08d6a202c704156a62bb675baba05b93ff1923ef0e4ac7a947263c0f1cd::cwiffhat {
    struct CWIFFHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CWIFFHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CWIFFHAT>(arg0, 6, b"CWIFFHAT", b"Chill Wif Hat", b"Just Chill Wif Hat!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/N_Zh9jv_QK_400x400_68b20e13cc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CWIFFHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CWIFFHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

