module 0xc68c44460a8b85af01c8b5284244fe019903daa8867d9fd2b4fa37d1c92941d9::grc {
    struct GRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRC>(arg0, 6, b"GRC", b"Green Red Cat on Sui", b"First Green Red Cat on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/472f9545fb04a191e6b3a2f1def74319_ef0f4d6697.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRC>>(v1);
    }

    // decompiled from Move bytecode v6
}

