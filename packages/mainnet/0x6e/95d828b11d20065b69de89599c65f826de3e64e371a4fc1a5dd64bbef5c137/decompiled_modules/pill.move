module 0x6e95d828b11d20065b69de89599c65f826de3e64e371a4fc1a5dd64bbef5c137::pill {
    struct PILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PILL>(arg0, 6, b"PILL", b"Redpill", b"Unified, Faster & Economic", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4pu53n55_400x400_8e858e7597.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PILL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PILL>>(v1);
    }

    // decompiled from Move bytecode v6
}

