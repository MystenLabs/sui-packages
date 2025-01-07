module 0x2b03cb7269e6ba670242b15e24989bf3444b679ef0d98fdc3fb4106da5c306bd::moz {
    struct MOZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOZ>(arg0, 6, b"MOZ", b"Mozaic Token", b"AI-Optimized Yield and Liquidity Strategies ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/of_Q5_Wu_M6_400x400_033f342544.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

