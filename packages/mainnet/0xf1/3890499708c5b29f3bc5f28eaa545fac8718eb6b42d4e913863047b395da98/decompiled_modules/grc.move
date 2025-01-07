module 0xf13890499708c5b29f3bc5f28eaa545fac8718eb6b42d4e913863047b395da98::grc {
    struct GRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRC>(arg0, 6, b"GRC", b"Green Red Cat on Sui", b"First Green Red Cat on Sui Real", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/472f9545fb04a191e6b3a2f1def74319_40e3e697c6.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRC>>(v1);
    }

    // decompiled from Move bytecode v6
}

