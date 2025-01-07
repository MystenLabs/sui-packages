module 0x7e41b1d8d865c24ca26da25a0d8ebbae6af9f9acfcbeb2033a4cef414598e452::cunt {
    struct CUNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUNT>(arg0, 6, b"CUNT", b"C*NT WARS", b"YOU'LL DEFINITELY GONNA LOVE THIS !!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_22_12_2024_12218_x_com_63c9acd717.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CUNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

