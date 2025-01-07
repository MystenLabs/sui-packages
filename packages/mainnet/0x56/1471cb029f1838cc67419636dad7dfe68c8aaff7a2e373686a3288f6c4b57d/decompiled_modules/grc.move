module 0x561471cb029f1838cc67419636dad7dfe68c8aaff7a2e373686a3288f6c4b57d::grc {
    struct GRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GRC>(arg0, 6, b"GRC", b"Green Red Cat", b"Memecoin on Sui!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/472f9545fb04a191e6b3a2f1def74319_667b5c654f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRC>>(v1);
    }

    // decompiled from Move bytecode v6
}

