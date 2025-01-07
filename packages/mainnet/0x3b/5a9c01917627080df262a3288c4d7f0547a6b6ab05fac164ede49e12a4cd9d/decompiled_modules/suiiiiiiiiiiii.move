module 0x3b5a9c01917627080df262a3288c4d7f0547a6b6ab05fac164ede49e12a4cd9d::suiiiiiiiiiiii {
    struct SUIIIIIIIIIIII has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIIIIIIIIIIII, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIIIIIIIIIIII>(arg0, 6, b"SUIIIIIIIIIIII", b"Cristiano Ronaldo", b"SUIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIIII", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_26_07_56_21_680838a024.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIIIIIIIIIIII>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIIIIIIIIIIII>>(v1);
    }

    // decompiled from Move bytecode v6
}

