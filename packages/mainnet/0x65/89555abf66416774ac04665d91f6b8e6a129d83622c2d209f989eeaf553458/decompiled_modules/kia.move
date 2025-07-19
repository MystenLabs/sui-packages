module 0x6589555abf66416774ac04665d91f6b8e6a129d83622c2d209f989eeaf553458::kia {
    struct KIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIA>(arg0, 6, b"KIA", b"Kia The Dog", b"Meet Kia! Ika's beloved and loyal dog.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeiesvwvoouo7ln5x55iedoovcx7uza3hnbjkrg7grblthnsbtyuaxy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KIA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

