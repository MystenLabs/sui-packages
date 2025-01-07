module 0x59392b4141be0617de490416ddc724e3a106936361b700a8d88ea9e142a8b2e3::maadysui {
    struct MAADYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAADYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAADYSUI>(arg0, 6, b"MAADYSUI", b"Maady", b"Introducing $maady, the new meme coin on SUI network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_17_43_51_6326e0343d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAADYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAADYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

