module 0xa005f99d047a430cc52ac856b55d742432a4cf68aeb6ef7dfbf2c6ccaf4a2445::egg {
    struct EGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EGG>(arg0, 6, b"EGG", b"World Record Egg", x"54686520576f726c64205265636f726420456767206973206e6f77206f6666696369616c6c79206f6e20537569210a0a4c6574277320736574206120776f726c64207265636f726420746f67657468657221", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9969_c3a7a5689b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

