module 0xfe13664f94dbf29dc4f24cc92d57adcf3922ed55ebc4dff45393a6b27376660f::mikasa {
    struct MIKASA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKASA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKASA>(arg0, 6, b"MIKASA", b"Mikasa on SUI", b"Titan Slayer!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/40b_X_rfv_400x400_e60839bc51.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKASA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIKASA>>(v1);
    }

    // decompiled from Move bytecode v6
}

