module 0x8dad4234a64a0827cb50c2c58bd038f5af504b553f586c88dc4260c392bfc4d2::squidward {
    struct SQUIDWARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIDWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIDWARD>(arg0, 6, b"SQUIDWARD", b"Squidward on Sui", b"Grumpy and unimpressed, $SQUIDWARD brings his signature sarcasm and clarinet vibes to the Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_11_d3fe2ed6a2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIDWARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIDWARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

