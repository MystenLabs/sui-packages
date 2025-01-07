module 0xefd8b9f43aa7ff937d26637ee728722aa84f2073a4608756ce460d1fe97f8ac1::caesar {
    struct CAESAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAESAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAESAR>(arg0, 6, b"CAESAR", b"CAESAR SUI", b"Apes together strong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_03_12_47_removebg_preview_300x300_e365aac0cf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAESAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAESAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

