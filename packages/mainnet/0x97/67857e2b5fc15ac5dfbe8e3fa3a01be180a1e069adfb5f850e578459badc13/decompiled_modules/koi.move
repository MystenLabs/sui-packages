module 0x9767857e2b5fc15ac5dfbe8e3fa3a01be180a1e069adfb5f850e578459badc13::koi {
    struct KOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOI>(arg0, 6, b"KOI", b"KOI FISH", x"4120426f6c642046697368204d616b696e67205761766573206f66205765616c746820696e2074686520537569204f6365616e20535549206e6574776f726b0a20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0x01d430425a8a681ef26315e78a082fe744f8d0bbdbd1ab76b9fd78ada09bedca_koi_koi_af89273a8d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

