module 0x808652ce4e68a8d6b0a402a2583731878f75baaca48022ba045d525fb842b000::pig {
    struct PIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIG>(arg0, 6, b"PIG", b"Pig", b"The most telegram-native memecoin | Head to Telegram to count your friends, see your total, and redeem your rewards! #PIGS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OE_Yv4_J2l_400x400_7edab1bf63.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

