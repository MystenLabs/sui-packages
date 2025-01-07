module 0x6f302962ec6fe6be57b740ab4097191bed12c9d956e3ebfd792887028c55fc26::wintrb {
    struct WINTRB has drop {
        dummy_field: bool,
    }

    fun init(arg0: WINTRB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WINTRB>(arg0, 6, b"WINTRB", b"Winter bear", b"Its the winter season, winter bear (polar bear) is here with us on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1539_727c07ea4a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WINTRB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WINTRB>>(v1);
    }

    // decompiled from Move bytecode v6
}

