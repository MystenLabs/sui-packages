module 0xbdebd0a6157e1d462e11aa665d7c386243efa764bea6c2ff0a318e69ec3d856b::toki {
    struct TOKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOKI>(arg0, 6, b"Toki", b"TOKI_THE_HIPPO_DOG", b"Toki is no ordinary puppyhes a delightful mix of dog and hippo, thanks to a unique genetic mutation that has gifted him with a one-of-a-kind look.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LA_vs_Yny_400x400_13c132efe2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

