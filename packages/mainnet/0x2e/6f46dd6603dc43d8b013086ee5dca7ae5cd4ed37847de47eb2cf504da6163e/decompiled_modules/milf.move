module 0x2e6f46dd6603dc43d8b013086ee5dca7ae5cd4ed37847de47eb2cf504da6163e::milf {
    struct MILF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILF>(arg0, 6, b"MILF", b"Mommy SUI", x"4d6f6d6d79205355492069732074686520484f5454455354206d656d6520746f6b656e206f6e20535549204e6574776f726b21200a0a546865207469636b657220697320244d494c46", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_86_removebg_preview_90b7f1c92a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILF>>(v1);
    }

    // decompiled from Move bytecode v6
}

