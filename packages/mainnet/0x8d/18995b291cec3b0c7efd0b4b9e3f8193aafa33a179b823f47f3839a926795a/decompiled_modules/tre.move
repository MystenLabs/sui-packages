module 0x8d18995b291cec3b0c7efd0b4b9e3f8193aafa33a179b823f47f3839a926795a::tre {
    struct TRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRE>(arg0, 0x9e20798d97c110f6b36b7b3d8543aa9246322ef2fd8d83ad79ef3325d473bc2f::constants::lp_decimals(), b"TRE", b"TREND", b"A systematic, rule-based approach to crypto trading with dynamic risk management", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/commons/3/33/Cartoon_space_rocket.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

