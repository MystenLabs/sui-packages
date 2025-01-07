module 0x7c03fe4ac29730df4a8605ab5f32be2fc758f0d4e6e461a72db103119b8d26b4::rfd {
    struct RFD has drop {
        dummy_field: bool,
    }

    fun init(arg0: RFD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RFD>(arg0, 6, b"RFD", b"ReFund Sui", b"Created by Blurr.eth Follow us down the DeFi Rabbit Hole :// ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_09_23_06_23_76b252abcf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RFD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RFD>>(v1);
    }

    // decompiled from Move bytecode v6
}

