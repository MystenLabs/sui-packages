module 0x2f7b77daf254797851686a83a9b50407101bf11bd34e02f7f6a19bd1f001d592::miku {
    struct MIKU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIKU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIKU>(arg0, 6, b"MIKU", b"Degen Miku", b"The crypto version of MIKU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/W3_Dv_E7z_E_400x400_d1c121a90c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIKU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIKU>>(v1);
    }

    // decompiled from Move bytecode v6
}

