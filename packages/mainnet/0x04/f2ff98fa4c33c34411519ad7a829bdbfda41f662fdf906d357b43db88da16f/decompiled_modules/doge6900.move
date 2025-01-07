module 0x4f2ff98fa4c33c34411519ad7a829bdbfda41f662fdf906d357b43db88da16f::doge6900 {
    struct DOGE6900 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGE6900, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGE6900>(arg0, 6, b"DOGE6900", b"Doge6900", b"Join the $DOGE6900 Army.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_14_16_27_50_36db2e2b8d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGE6900>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGE6900>>(v1);
    }

    // decompiled from Move bytecode v6
}

