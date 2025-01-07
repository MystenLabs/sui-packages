module 0xb6ed7c534fae6a42f56ed53ea8b647d4869a4938477ac73068aa3bacc8430de3::tama {
    struct TAMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAMA>(arg0, 6, b"TAMA", b"SUITAMA", b"$TAMA $TAMA $TAMA 2001 Suitama's helping you navigate crypto $TAMA $TAMA $TAMA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suitma_2cb102b713.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TAMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

