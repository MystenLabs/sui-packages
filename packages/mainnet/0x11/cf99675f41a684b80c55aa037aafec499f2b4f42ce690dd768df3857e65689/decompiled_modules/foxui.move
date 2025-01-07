module 0x11cf99675f41a684b80c55aa037aafec499f2b4f42ce690dd768df3857e65689::foxui {
    struct FOXUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOXUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOXUI>(arg0, 6, b"FOXUI", b"SUI FOX", b"The SUI FOX IS HERE TO BE NO.1 MEME on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/foxui_logo_new_a1897ca43c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOXUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOXUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

