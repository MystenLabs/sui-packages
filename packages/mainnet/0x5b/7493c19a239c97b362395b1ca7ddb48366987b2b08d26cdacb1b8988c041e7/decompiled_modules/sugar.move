module 0x5b7493c19a239c97b362395b1ca7ddb48366987b2b08d26cdacb1b8988c041e7::sugar {
    struct SUGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUGAR>(arg0, 6, b"SuGar", b"SuGars", b"Sugar baby!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_18_17_38_52_fotor_bg_remover_20240918174910_05ef2fc8bb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUGAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUGAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

