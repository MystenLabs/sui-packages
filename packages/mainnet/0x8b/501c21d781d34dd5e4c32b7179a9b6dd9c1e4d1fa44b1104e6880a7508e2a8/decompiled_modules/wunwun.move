module 0x8b501c21d781d34dd5e4c32b7179a9b6dd9c1e4d1fa44b1104e6880a7508e2a8::wunwun {
    struct WUNWUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WUNWUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WUNWUN>(arg0, 6, b"WUNWUN", b"Wunwunchi", b"Wunwunchi the dog meets sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1728354922252_769bfe17fd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WUNWUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WUNWUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

