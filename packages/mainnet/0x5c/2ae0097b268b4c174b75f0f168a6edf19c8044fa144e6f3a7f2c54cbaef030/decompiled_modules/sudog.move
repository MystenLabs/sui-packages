module 0x5c2ae0097b268b4c174b75f0f168a6edf19c8044fa144e6f3a7f2c54cbaef030::sudog {
    struct SUDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUDOG>(arg0, 6, b"SuDoG", b"SuiDog", b"Spike frend Tom and Jerry", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Spike_fdffc6067f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

