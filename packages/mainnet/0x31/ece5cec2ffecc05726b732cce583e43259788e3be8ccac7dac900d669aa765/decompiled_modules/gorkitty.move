module 0x31ece5cec2ffecc05726b732cce583e43259788e3be8ccac7dac900d669aa765::gorkitty {
    struct GORKITTY has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<GORKITTY>, arg1: address, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg3) == @0x30b55a5bca74ce5b2287b75de9bfa46e0f3f365b3c95df10b1f504647aac89cb, 0);
        0x2::transfer::public_transfer<0x2::coin::Coin<GORKITTY>>(0x2::coin::mint<GORKITTY>(arg0, arg2, arg3), arg1);
    }

    fun init(arg0: GORKITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GORKITTY>(arg0, 9, b"GORKITTY", b"Gorkitty", b"Gorkitty on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/JzyJhjR4/Qm-XUr-Qc43c4xxn-JNWC5a9x-Ku-CY3s5q2j1u-CSYc-Hb-C5vye-R.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GORKITTY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GORKITTY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

