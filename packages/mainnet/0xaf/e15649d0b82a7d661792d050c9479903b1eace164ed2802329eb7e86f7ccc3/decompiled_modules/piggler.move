module 0xafe15649d0b82a7d661792d050c9479903b1eace164ed2802329eb7e86f7ccc3::piggler {
    struct PIGGLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIGGLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIGGLER>(arg0, 6, b"Piggler", b"Piggler Fish", b"Piggler is the new era of memecoins. Forget cats, dogs, or frogs!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifjecudqpcns7m7jnkdx3kcgaqfowajwz4m2dwrblhc43sov5axh4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIGGLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIGGLER>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

