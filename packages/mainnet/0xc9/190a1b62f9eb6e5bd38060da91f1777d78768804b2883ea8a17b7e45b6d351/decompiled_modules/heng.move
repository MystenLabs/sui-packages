module 0xc9190a1b62f9eb6e5bd38060da91f1777d78768804b2883ea8a17b7e45b6d351::heng {
    struct HENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HENG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<HENG>(arg0, 6, b"HENG", b"H by SuiAI", b"HENGHENG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_8196_10b119cb9b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HENG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HENG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

