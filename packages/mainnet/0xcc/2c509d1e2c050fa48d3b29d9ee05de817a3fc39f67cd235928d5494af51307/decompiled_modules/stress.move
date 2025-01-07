module 0xcc2c509d1e2c050fa48d3b29d9ee05de817a3fc39f67cd235928d5494af51307::stress {
    struct STRESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRESS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STRESS>(arg0, 6, b"STRESS", b"$STRESS", x"5468697320596f756e6720426f792068617320676f742061206c6f74206f662024535452455353200a0a4d6179626520486520697320524943483f0a0a52756e2062792074686520436f6d6d756e69747920666f722074686520436f6d6d756e6974790a0a2453545245535320", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/STRESS_7b1b5f9900.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRESS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STRESS>>(v1);
    }

    // decompiled from Move bytecode v6
}

