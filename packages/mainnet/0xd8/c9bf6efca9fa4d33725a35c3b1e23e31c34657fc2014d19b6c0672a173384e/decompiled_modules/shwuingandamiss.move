module 0xd8c9bf6efca9fa4d33725a35c3b1e23e31c34657fc2014d19b6c0672a173384e::shwuingandamiss {
    struct SHWUINGANDAMISS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHWUINGANDAMISS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHWUINGANDAMISS>(arg0, 6, b"Shwuingandamiss", b"Plump", b"SWING AND A MISS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"http://movepump.xyz/uploads/2024_06_14_14_48_56_cd2ee1313e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHWUINGANDAMISS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHWUINGANDAMISS>>(v1);
    }

    // decompiled from Move bytecode v6
}

