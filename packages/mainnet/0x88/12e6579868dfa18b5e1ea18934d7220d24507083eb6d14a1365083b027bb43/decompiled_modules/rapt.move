module 0x8812e6579868dfa18b5e1ea18934d7220d24507083eb6d14a1365083b027bb43::rapt {
    struct RAPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RAPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RAPT>(arg0, 6, b"RAPT", b"Raptos", b"Kaaawwww! Kaaawwww! https://t.me/raptoscoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/of_E0o_B0r_400x400_db4465eda5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RAPT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RAPT>>(v1);
    }

    // decompiled from Move bytecode v6
}

