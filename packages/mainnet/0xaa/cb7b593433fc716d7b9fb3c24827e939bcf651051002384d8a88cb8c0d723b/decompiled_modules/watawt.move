module 0xaacb7b593433fc716d7b9fb3c24827e939bcf651051002384d8a88cb8c0d723b::watawt {
    struct WATAWT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATAWT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATAWT>(arg0, 6, b"WATAWT", b"wweeee", b"ewaww", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732485630109.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WATAWT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATAWT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

