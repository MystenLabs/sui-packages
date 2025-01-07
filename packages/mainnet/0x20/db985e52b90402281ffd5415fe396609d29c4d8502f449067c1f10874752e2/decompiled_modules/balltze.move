module 0x20db985e52b90402281ffd5415fe396609d29c4d8502f449067c1f10874752e2::balltze {
    struct BALLTZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALLTZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALLTZE>(arg0, 6, b"BALLTZE", b"Balltze", b"affectionately known as \"Cheems,\" was a Shiba Inu dog who became an internet sensation.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241003_013005_671_035e88cfef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALLTZE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALLTZE>>(v1);
    }

    // decompiled from Move bytecode v6
}

