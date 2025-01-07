module 0x33a3bae258de7bbc1f7ae3db180973aba2b6cfe7865385f3f06f34161233c6a7::dinosui {
    struct DINOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DINOSUI>(arg0, 6, b"DINOSUI", b"DINO", x"706172747920616e64206578706c6f72652073756920776974682064696e6f206c65742773206d616b6520697420612066756e20706c616365212121212121212121210a0a4c455453204655434b494e472044494e4f2121212121212121212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9c4f9847_965b_4bbc_a7b4_c303759fae9b_2f1fccce59.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DINOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

