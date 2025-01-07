module 0x3404e3509ab5c19c2274cd7237f0f6ab1e26c2d40fcc2c9549a92a58326eb92e::mgga {
    struct MGGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MGGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MGGA>(arg0, 6, b"MGGA", b"Make Games Great Again", x"4d616b652047616d657320477265617420416761696e0a5265766976696e672074686520737069726974206f662067616d696e67206f6e20537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000505339_794a979a7f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MGGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MGGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

