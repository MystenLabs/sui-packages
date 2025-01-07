module 0x44886d7eedcbc4500f11b2505a05256cabcc34e9e7de2bb7ab93fe0be9784216::suiger {
    struct SUIGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGER>(arg0, 6, b"Suiger", b"SUIGER", b"Aint that cute. Fomo is quite the doozy, eh? But since youre here, Ill guide you through ittry to keep up", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Mme9_U8_Q_400x400_42a1d3671a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

