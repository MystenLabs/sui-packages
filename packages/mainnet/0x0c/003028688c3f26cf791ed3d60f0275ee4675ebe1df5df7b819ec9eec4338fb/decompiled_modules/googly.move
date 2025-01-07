module 0xc003028688c3f26cf791ed3d60f0275ee4675ebe1df5df7b819ec9eec4338fb::googly {
    struct GOOGLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOGLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOGLY>(arg0, 6, b"GOOGLY", b"Googly Cat Sui", b"$GOOGLY - The cutest and coolest memecoin of the future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Xj0p8_s_Q_400x400_607155a493.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOGLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOOGLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

