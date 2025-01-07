module 0x1ba561f047fd76a116c063dae1789e9d61ea7b22f79404f67283d6f6710d336d::siuuu {
    struct SIUUU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIUUU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIUUU>(arg0, 6, b"SIUUU", b"CR7 SIUUU", b"CR7 is now at home on the SUI network. Its time to make some noise", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_12_13_11_42_23_ff86f02f45.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIUUU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIUUU>>(v1);
    }

    // decompiled from Move bytecode v6
}

