module 0xfc469f9b1f6de7f5607b7dd89f9b0936b6f619ef97fe2047e5df3d2f2e6c0ff3::fuck {
    struct FUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCK>(arg0, 6, b"FUCK", b"FUCK Sniper", b"I hate Sniper", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_a05e3371e9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

