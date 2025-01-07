module 0x84bdbf00b3670584596c8f77a204665e16b232b5200a7d82641118b9c48392ca::aaadog {
    struct AAADOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAADOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAADOG>(arg0, 6, b"AAAdog", b"AAADOG", x"4141414141414141414141200a43616e27742073746f7020776f6e27742073746f7020287468696e6b696e672061626f75742053756929", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1361728836203_pic_d482e1cd87.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAADOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAADOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

