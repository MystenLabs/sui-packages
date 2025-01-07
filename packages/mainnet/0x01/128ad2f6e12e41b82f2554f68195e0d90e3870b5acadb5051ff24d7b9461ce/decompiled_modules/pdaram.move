module 0x1128ad2f6e12e41b82f2554f68195e0d90e3870b5acadb5051ff24d7b9461ce::pdaram {
    struct PDARAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDARAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDARAM>(arg0, 6, b"PDARAM", b"DARAM PRO", b"FIRST DARAM ON SUI. https://www.daramonsui.pro | https://t.me/DARAMSui_Portal | https://www.daramonsui.pro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_08_22015708_664ac065aa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDARAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PDARAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

