module 0xe82a92cf0d1526a4f3cc470dbaf74b74a8692efd7c82304e585d1114c78bf641::bondman {
    struct BONDMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONDMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONDMAN>(arg0, 6, b"BONDMAN", b"BONDSUUUUI", b"BONDMAN FROM SPYXFAMILY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9790_8be14ee21a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONDMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONDMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

