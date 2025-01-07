module 0x60e55044a129e4120ce586d8251a02db95f5b75bef1cb34e669a711440b1a340::dizzy {
    struct DIZZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIZZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIZZY>(arg0, 6, b"DIZZY", b"Dizzy on sui", x"4d6565742044495a5a592c2047656b6b6f277320666561726c6573732061726d6164696c6c6f206e6f770a6c697665206f6e207468652053756920626c6f636b636861696e21204275696c74206f6e20737472656e6774680a616e642061646170746162696c6974792c207468697320746f6b656e207265766f6c7574696f6e697a65730a4465466920616e64204e465473207769746820756e73746f707061626c6520656e657267792e0a4a6f696e2044495a5a59206173206865206c6561647320746865206368617267650a696e746f2074686520667574757265206f6620746865205375692065636f73797374656d21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052722_2a8c9753f0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIZZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIZZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

