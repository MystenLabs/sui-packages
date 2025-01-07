module 0xe441a17615f7638344441de8edcd73e36e069262ed0350356c86bdb413baf7eb::wiff {
    struct WIFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIFF>(arg0, 6, b"WIFF", b"Man Bear Pig Wif", b"Wif", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LXJO_3267_b077770253.JPEG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WIFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

