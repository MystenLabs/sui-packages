module 0x525e1400c0fcd21b4f2d5bc73436c7142e26b1d23bf3f984ba8fc1cb10892e4d::spig {
    struct SPIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIG>(arg0, 6, b"SPIG", b"Suipig", b"Oink oink - suipig.xyz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_180921_0b38fdb579.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

