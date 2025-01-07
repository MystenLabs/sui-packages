module 0x4d8e5e4266f69a5215f8537a2c4ab97ac4dd6ea3658417950f7c69d8f066fe0a::netzy {
    struct NETZY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NETZY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NETZY>(arg0, 6, b"Netzy", b"Net Zy", b"During the launch, some bots were used to swipe, temporarily impacting the market cap. They have since sold, and now we can move forward together to reach new heights!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_ea066abdd5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NETZY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NETZY>>(v1);
    }

    // decompiled from Move bytecode v6
}

