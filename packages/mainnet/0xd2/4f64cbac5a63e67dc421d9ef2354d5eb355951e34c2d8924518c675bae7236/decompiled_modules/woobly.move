module 0xd24f64cbac5a63e67dc421d9ef2354d5eb355951e34c2d8924518c675bae7236::woobly {
    struct WOOBLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOOBLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOOBLY>(arg0, 6, b"WOOBLY", b"Woobly on SUI", b"Woobly is a symbol of endless joy, spreading smiles across every corner of the SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/woobly_1689324909.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOOBLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOOBLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

