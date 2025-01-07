module 0x65db1ae4172f887c63744e4435c5c7aed04e86e63291ddfd864676897fcfa3c0::snut {
    struct SNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNUT>(arg0, 6, b"SNUT", b"SEANUT ARC on SUI", x"4e6f74206120636f70792c206a757374207468696e6b696e6720696e2073696d706c79206e65742c20697420697320776861742061206361746368696e6720766962652e0a6a6f696e20746865205345414e555453205041525459203a2068747470733a2f2f742e6d652f5365616e75744172634f6e535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/O_Oj_Zdgpc_400x400_1845d355f0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNUT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNUT>>(v1);
    }

    // decompiled from Move bytecode v6
}

