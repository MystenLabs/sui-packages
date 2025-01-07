module 0x735ac5bfc33a78515345f228c208536ee167d2701c847041b20788b7d0700262::iphone16 {
    struct IPHONE16 has drop {
        dummy_field: bool,
    }

    fun init(arg0: IPHONE16, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IPHONE16>(arg0, 6, b"IPHONE16", b"iPhone 16", b"MY NAME IS IPHONE 16", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726330026664_028f207b15a55bd36dfd2e10f32cd227_ee3a6f7d92.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IPHONE16>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IPHONE16>>(v1);
    }

    // decompiled from Move bytecode v6
}

