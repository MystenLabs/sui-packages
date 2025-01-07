module 0xfb62fac8d1ec6b479f8c4dd1cc32f85ff2a06ac17f99b195af07c6db4faaa11::skdr {
    struct SKDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKDR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKDR>(arg0, 6, b"SKDR", b"SuiKaD_Rugggs", b"Suikadrug is a fictional character born from the imagination of a guy who's high, as if he's on his way to the moon.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pikadrug_e6fc3c672a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKDR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKDR>>(v1);
    }

    // decompiled from Move bytecode v6
}

