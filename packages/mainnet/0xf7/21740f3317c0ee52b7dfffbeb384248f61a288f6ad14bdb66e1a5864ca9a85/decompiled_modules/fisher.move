module 0xf721740f3317c0ee52b7dfffbeb384248f61a288f6ad14bdb66e1a5864ca9a85::fisher {
    struct FISHER has drop {
        dummy_field: bool,
    }

    fun init(arg0: FISHER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FISHER>(arg0, 6, b"FISHER", b"the fisher", b"i hunt fish on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AFAD_3_FB_6_A205_47_FD_8_F12_3_D52_D412_B8_E5_e3928d9100.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FISHER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FISHER>>(v1);
    }

    // decompiled from Move bytecode v6
}

