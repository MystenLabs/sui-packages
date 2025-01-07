module 0x8549593f0badc13902577a5a8094d58984be7bdbfc40ac42fce0caae5a8e7479::issui {
    struct ISSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISSUI>(arg0, 6, b"ISSUI", b"ISSUE", b"Damm issue ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8987_3e0fe75ac3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ISSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ISSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

