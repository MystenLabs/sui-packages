module 0x51018f699a8567c00da2ac8c17fbfc7216dfe48af1d5f79555c1e5ee9b8e18f3::bdog {
    struct BDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDOG>(arg0, 6, b"BDOG", b"blue eyed dog", b"A blue eyed dog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/m4_ZT_8t_Im_400x400_d00e600e9f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

