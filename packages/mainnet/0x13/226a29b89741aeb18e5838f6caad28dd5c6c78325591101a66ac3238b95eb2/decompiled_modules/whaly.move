module 0x13226a29b89741aeb18e5838f6caad28dd5c6c78325591101a66ac3238b95eb2::whaly {
    struct WHALY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALY>(arg0, 6, b"WHALY", b"Whaly On Sui", b"Whaly glides effortlessly through the deep ocean of the crypto market, its massive presence shifting the tides.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241010_101825_0558a96cdd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALY>>(v1);
    }

    // decompiled from Move bytecode v6
}

