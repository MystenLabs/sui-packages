module 0xf5fbe386ac8520cb7f7aaa58ebdff3a73678cd90db9673d82d1e1cfb03260c30::farts {
    struct FARTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FARTS>(arg0, 6, b"Farts", b"FungibleFarts", x"536d656c6c20746865206675747572652c20686f6c64207468652046617274732e204a6f696e207468652066756e6e696573742066696e616e6369616c207265766f6c7574696f6e206f66206f75722074696d652e0a0a44657369676e656420666f72205355492068756d6f7220616e6420696e6e6f766174696f6e2062656c6965766572732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_12_19_at_10_09_48a_AM_bda6bd148d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FARTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

