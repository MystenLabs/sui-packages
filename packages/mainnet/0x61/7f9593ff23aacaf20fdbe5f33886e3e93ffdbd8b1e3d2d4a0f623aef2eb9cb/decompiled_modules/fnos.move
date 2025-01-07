module 0x617f9593ff23aacaf20fdbe5f33886e3e93ffdbd8b1e3d2d4a0f623aef2eb9cb::fnos {
    struct FNOS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FNOS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FNOS>(arg0, 6, b"FNOS", b"First Neiro On Sui", b"First $Neiro on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000186125_3fe9a7d2a0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FNOS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FNOS>>(v1);
    }

    // decompiled from Move bytecode v6
}

