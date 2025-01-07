module 0xa30b383f0778b4be6dfb0f593195a979e216e2f2521a27593be6c1e4f0d67567::ndoge {
    struct NDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NDOGE>(arg0, 6, b"NDOGE", b"NarwhaleDoge on Sui", x"41206d6978206265747765656e204e61727768616c20616e6420446f676520244e444f4745206f6e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Narwhale_Doge_on_Sui_2cf86e68a9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

