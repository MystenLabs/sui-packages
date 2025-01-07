module 0x3e12f7916a63d290405727e338f4febf0103bddb130dc4cb5913af04b0840d23::gbi {
    struct GBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GBI>(arg0, 9, b"GBI", b"Garbi", b"Healthy Heart ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0f000383-de11-403c-8657-1fd37133469f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

