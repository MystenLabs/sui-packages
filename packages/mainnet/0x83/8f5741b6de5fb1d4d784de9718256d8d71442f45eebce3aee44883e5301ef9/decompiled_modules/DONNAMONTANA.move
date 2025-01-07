module 0x838f5741b6de5fb1d4d784de9718256d8d71442f45eebce3aee44883e5301ef9::DONNAMONTANA {
    struct DONNAMONTANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONNAMONTANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONNAMONTANA>(arg0, 6, b"DONNAMONTANA", b"DONNAMONTANA", b"Find Our Community On Discord", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/AISSlQJ.jpeg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DONNAMONTANA>(&mut v2, 200000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONNAMONTANA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONNAMONTANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

