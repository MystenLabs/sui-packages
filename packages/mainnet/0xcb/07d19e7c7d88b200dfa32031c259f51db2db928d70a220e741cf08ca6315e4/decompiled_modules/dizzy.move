module 0xcb07d19e7c7d88b200dfa32031c259f51db2db928d70a220e741cf08ca6315e4::dizzy {
    struct DIZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIZZY>(arg0, 6, b"DIZZY", b"DIZZY ON SUI", x"4d6565742044495a5a592c2047656b6b6f277320666561726c6573732061726d6164696c6c6f206e6f770a6c697665206f6e207468652053756920626c6f636b636861696e21204275696c74206f6e20737472656e67746820616e640a61646170746162696c6974792c207468697320746f6b656e207265766f6c7574696f6e697a6573204465466920616e64204e4654730a7769746820756e73746f707061626c6520656e657267792e204a6f696e2044495a5a59206173206865206c656164730a7468652063686172676520696e746f2074686520667574757265206f6620746865205375692065636f73797374656d21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/dizzy_25560c18e7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIZZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIZZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

