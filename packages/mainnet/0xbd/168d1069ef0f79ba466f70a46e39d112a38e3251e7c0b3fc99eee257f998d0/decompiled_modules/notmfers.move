module 0xbd168d1069ef0f79ba466f70a46e39d112a38e3251e7c0b3fc99eee257f998d0::notmfers {
    struct NOTMFERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOTMFERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOTMFERS>(arg0, 6, b"NOTmfers", b"This is NOTmfers", b"Will do something with community", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NO_Tmfers_Basic_Blue_188acf00fd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOTMFERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOTMFERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

