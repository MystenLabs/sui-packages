module 0x6829b21250b98b5050a2a0fbc3f9ca19d067e424d39cda5c440131ab9eb4c7a3::milf {
    struct MILF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MILF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MILF>(arg0, 6, b"MILF", b"Milfs On SUI", b"Telegram only for now ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3538_4b5256d844.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MILF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MILF>>(v1);
    }

    // decompiled from Move bytecode v6
}

