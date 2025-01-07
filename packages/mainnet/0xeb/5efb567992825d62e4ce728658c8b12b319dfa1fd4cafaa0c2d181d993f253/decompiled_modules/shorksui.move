module 0xeb5efb567992825d62e4ce728658c8b12b319dfa1fd4cafaa0c2d181d993f253::shorksui {
    struct SHORKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHORKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHORKSUI>(arg0, 6, b"SHORKSUI", b"SHORK ON SUI", x"5269646520746865205355492057617665200a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/92_R9239_RM_47f24df351.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHORKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHORKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

