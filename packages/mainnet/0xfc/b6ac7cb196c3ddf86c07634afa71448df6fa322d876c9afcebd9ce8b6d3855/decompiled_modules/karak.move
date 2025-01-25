module 0xfcb6ac7cb196c3ddf86c07634afa71448df6fa322d876c9afcebd9ce8b6d3855::karak {
    struct KARAK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KARAK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KARAK>(arg0, 6, b"Karak", b"Karak Enjoyooor", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i7e7al_Pd_400x400_795ae2b9c2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KARAK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KARAK>>(v1);
    }

    // decompiled from Move bytecode v6
}

