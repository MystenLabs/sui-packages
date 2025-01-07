module 0x833f74a76e2ca91d7522d1c785d0e8c8e9d1701471e0b96e969cedbd5279013e::octosui {
    struct OCTOSUI has drop {
        dummy_field: bool,
    }

    fun create_currency<T0: drop>(arg0: T0, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<T0> {
        let (v0, v1) = 0x2::coin::create_currency<T0>(arg0, 9, b"octosui", b"OCTO SUI PASS", b"Octopass is coming to Sui market - A meme token acting like a meme token.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1770766170758537217/L1PFOtVg_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<T0>>(v1);
        v0
    }

    fun init(arg0: OCTOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = create_currency<OCTOSUI>(arg0, arg1);
        0x2::coin::mint_and_transfer<OCTOSUI>(&mut v0, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCTOSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

