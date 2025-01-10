module 0xf218bef2212a155e07eea4e18e04b734e844634fb8bfdb18d0ff3f350e03c1e6::myc {
    struct MYC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MYC>(arg0, 6, b"MYC", b"My Chicken", b"Welcome to MYC - your path to crypto success!  the innovative chicken that lay s golden eggs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000022915_0393dafa7d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYC>>(v1);
    }

    // decompiled from Move bytecode v6
}

