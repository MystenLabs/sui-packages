module 0xcd6cff4d4d3005f0ad97a1e9c01af18f118b2f1f2320670ce1d725213da80e1e::robin {
    struct ROBIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBIN>(arg0, 6, b"Robin", b"Robin On Sui", b"rypto for everyone, not just the rich |  Take from the Rich, Give to the Poor |  Join the revolution", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ob7_L_Fek_400x400_c209630010.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

