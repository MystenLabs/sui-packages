module 0xfe4b0b83818ff4355978cbce60b6166380a376e34ec70435d7ff9297791254d1::dizzy {
    struct DIZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIZZY>(arg0, 6, b"DIZZY", b"Dizzy on SUI", x"4d6565742044495a5a592c2047656b6b6f277320666561726c6573732061726d6164696c6c6f206e6f77206c697665206f6e20746865205375690a626c6f636b636861696e21204275696c74206f6e20737472656e67746820616e642061646170746162696c6974792c207468697320746f6b656e0a7265766f6c7574696f6e697a6573204465466920616e64204e465473207769746820756e73746f707061626c6520656e657267792e204a6f696e0a44495a5a59206173206865206c65616473207468652063686172676520696e746f2074686520667574757265206f6620746865205375692065636f73797374656d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/carddizzy_f4c09654_d457ce8901.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIZZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIZZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

