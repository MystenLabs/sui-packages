module 0x31f5d26748d76c5e622fa5145c7f1070bc58efe032950a7e00884ffc979f0071::wawa {
    struct WAWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAWA>(arg0, 6, b"Wawa", b"Wawa cat", b"$Wawa just can't stop WAAAAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0ga_Zsu62_400x400_5fdd6fd5cc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

