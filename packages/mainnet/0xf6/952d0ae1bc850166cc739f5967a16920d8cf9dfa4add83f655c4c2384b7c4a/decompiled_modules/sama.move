module 0xf6952d0ae1bc850166cc739f5967a16920d8cf9dfa4add83f655c4c2384b7c4a::sama {
    struct SAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAMA>(arg0, 6, b"SAMA", b"SuiSama", b"o-machid sama", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008610_2987b59fc7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

