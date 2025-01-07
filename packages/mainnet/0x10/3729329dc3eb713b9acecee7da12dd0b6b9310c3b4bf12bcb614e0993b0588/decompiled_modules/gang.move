module 0x103729329dc3eb713b9acecee7da12dd0b6b9310c3b4bf12bcb614e0993b0588::gang {
    struct GANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GANG>(arg0, 6, b"Gang", b"Frog Gang", b" wATCH tHE sUI tOKEN pUMP aND tAKE oVER tHE bLoCKCHAIN.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000016802_733b2eb9eb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

