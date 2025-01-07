module 0x9dcafd9ca67db048cb888c8af36edd9c0800aa51ef4921be68e5006e8270d185::titis {
    struct TITIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TITIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TITIS>(arg0, 6, b"TITIS", b"SUITITS", b"Sui Double D ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5801_ebe9f6b252.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TITIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TITIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

