module 0xbf94f12e57baef9047d0708ecf94b29410ca261fc31af06519fda3cfe565ff50::xmassui {
    struct XMASSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XMASSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XMASSUI>(arg0, 6, b"XMASSUI", b"XMASSUI COM", b"XMASSUI.COM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Salinan_dari_Desain_Tanpa_Judul_5_1a63898899.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XMASSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XMASSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

