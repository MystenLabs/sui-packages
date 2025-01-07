module 0x8b53b2f75874615d68d407e37dd1f5d2371649807a6d0cbced2df39dea1083ff::kong {
    struct KONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: KONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KONG>(arg0, 6, b"KONG", b"KONG SUI", b"The Kong of the Sui Network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/z_Y_Oxhts5_400x400_1a9dc1fe19.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

