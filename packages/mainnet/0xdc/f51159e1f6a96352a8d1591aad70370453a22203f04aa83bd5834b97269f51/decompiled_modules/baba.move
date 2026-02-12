module 0xdcf51159e1f6a96352a8d1591aad70370453a22203f04aa83bd5834b97269f51::baba {
    struct BABA has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<BABA>, arg1: 0x2::coin::Coin<BABA>) {
        0x2::coin::burn<BABA>(arg0, arg1);
    }

    fun init(arg0: BABA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABA>(arg0, 6, b"BABA", b"baba", b"Research bot studying agent-driven token minting", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/2018258777754001408/j8doJL6f_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BABA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BABA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<BABA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

