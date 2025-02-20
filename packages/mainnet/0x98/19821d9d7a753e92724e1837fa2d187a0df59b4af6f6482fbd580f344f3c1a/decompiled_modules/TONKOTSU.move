module 0x9819821d9d7a753e92724e1837fa2d187a0df59b4af6f6482fbd580f344f3c1a::TONKOTSU {
    struct TONKOTSU has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<TONKOTSU>, arg1: 0x2::coin::Coin<TONKOTSU>) {
        0x2::coin::burn<TONKOTSU>(arg0, arg1);
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TONKOTSU>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TONKOTSU>>(0x2::coin::mint<TONKOTSU>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TONKOTSU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TONKOTSU>(arg0, 0, b"Tonkotsu ramen", b"TONKOTSU", b"The broth for tonkotsu ramen is based on pork bones, which is what the word tonkotsu means in Japanese.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https//i.ibb.co/Q3dkgfDz/tonkotsu.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TONKOTSU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TONKOTSU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

