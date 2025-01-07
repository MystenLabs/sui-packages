module 0x4ffc8e83904b6f33112d8271ceb665125e35f28cf687b071f6613046dff3411f::dolanf {
    struct DOLANF has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOLANF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOLANF>(arg0, 6, b"DOLANF", b"Dolan Duck Fun", b"Dexscreener Paid.Check now: https://dolanducksui.fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_2_d2f11a341f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOLANF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOLANF>>(v1);
    }

    // decompiled from Move bytecode v6
}

