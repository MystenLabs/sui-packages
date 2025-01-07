module 0xb97f8c9afaaf18e50adc6dcc23c820b3cec0321475c33fd002d8748f3da6cd0::stress {
    struct STRESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRESS>(arg0, 6, b"STRESS", b"$STRESS", x"2d3d5468697320596f756e6720426f792068617320676f742061206c6f74206f662024535452455353203d2d0a0a5f2b4d6179626520486520697320524943483f2b5f0a0a0a3c332052756e2062792074686520436f6d6d756e69747920666f722074686520436f6d6d756e697479203c330a0a536f6369616c7320696e20746865206d616b696e67200a0a446f6e27742020245354524553530a0a2453545245535320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/STRESS_7b1b5f9900.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

