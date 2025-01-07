module 0x78736670c6509b5c7107527260ae074ee375a0d6a8168b8d954b5e6eebabc0dc::sfn {
    struct SFN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SFN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SFN>(arg0, 6, b"SFN", b"SuiFren", b"SuiFren ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/RW_4_Xp_C25_400x400_ce0a59ae32.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SFN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SFN>>(v1);
    }

    // decompiled from Move bytecode v6
}

