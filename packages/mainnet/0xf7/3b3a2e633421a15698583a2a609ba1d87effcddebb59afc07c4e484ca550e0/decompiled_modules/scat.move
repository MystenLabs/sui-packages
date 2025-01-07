module 0xf73b3a2e633421a15698583a2a609ba1d87effcddebb59afc07c4e484ca550e0::scat {
    struct SCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCAT>(arg0, 6, b"SCAT", b"Sui Cat Coin", x"57656c636f6d6520746f20746865206461726b2073696465206f66205355490a0a54686973206973205375692043617420436f696e202d2024534341540a0a436865636b206f7572207765627369746520737569636174636f696e2e78797a0a0a54656c656772616d3a2068747470733a2f2f742e6d652f537569436174436f696e506f7274616c0a0a547769747465723a2068747470733a2f2f782e636f6d2f737569636174636f696e58", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1728793329955_ezgif_com_resize_4489fcfb16.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

