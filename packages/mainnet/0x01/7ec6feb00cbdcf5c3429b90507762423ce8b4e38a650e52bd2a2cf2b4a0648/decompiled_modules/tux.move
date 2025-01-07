module 0x17ec6feb00cbdcf5c3429b90507762423ce8b4e38a650e52bd2a2cf2b4a0648::tux {
    struct TUX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUX>(arg0, 6, b"TUX", b"Tux Penguin", b" launch penguin meme on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_16_21_03_1fedb1db11.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUX>>(v1);
    }

    // decompiled from Move bytecode v6
}

