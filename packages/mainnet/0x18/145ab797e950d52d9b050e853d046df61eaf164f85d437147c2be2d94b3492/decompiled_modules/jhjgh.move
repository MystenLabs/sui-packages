module 0x18145ab797e950d52d9b050e853d046df61eaf164f85d437147c2be2d94b3492::jhjgh {
    struct JHJGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: JHJGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JHJGH>(arg0, 9, b"JHJGH", b"XFGFG", b"VBNMBV", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7470945c-5984-44f2-8299-83b0ff1bb5b9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JHJGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JHJGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

