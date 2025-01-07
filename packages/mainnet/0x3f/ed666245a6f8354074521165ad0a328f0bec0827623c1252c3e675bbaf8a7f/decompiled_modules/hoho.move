module 0x3fed666245a6f8354074521165ad0a328f0bec0827623c1252c3e675bbaf8a7f::hoho {
    struct HOHO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOHO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOHO>(arg0, 6, b"HoHo", b"HOHO", b"A boy's hand drawn cartoon image The name is hoho", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241006_230732_077_894525158d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOHO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOHO>>(v1);
    }

    // decompiled from Move bytecode v6
}

