module 0xc4ea35438e7758b0b70628889c7a5efef588b94e22c1c95d71a3a421969c4b37::paws {
    struct PAWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWS>(arg0, 6, b"PAWS", b"PAWS AI SUI", b"PAWS AI SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/g_T_Teyxvg_400x400_1a6edb8e5f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

