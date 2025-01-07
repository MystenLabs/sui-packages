module 0x7c25b98c27018eb3896f1462feb436d04bb27f886400630ff9a268e1e6338339::suikeycat {
    struct SUIKEYCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIKEYCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIKEYCAT>(arg0, 6, b"SUIKEYCAT", b"KEYCAT", b"KeyboardCat ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/L_Nqt_P1ik_400x400_633498ecb2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIKEYCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIKEYCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

