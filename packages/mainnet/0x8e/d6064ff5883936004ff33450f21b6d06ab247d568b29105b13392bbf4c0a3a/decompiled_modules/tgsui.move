module 0x8ed6064ff5883936004ff33450f21b6d06ab247d568b29105b13392bbf4c0a3a::tgsui {
    struct TGSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGSUI>(arg0, 6, b"TGSUI", b"The guardian of sui", b"the guardian is the first original meme to protect sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241003_134545_416226000a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TGSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

