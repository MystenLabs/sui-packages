module 0x4b25bb444a41831beb49a3499691baee58df2d6d4d3eddb095ad4658c3a1cbd2::jet2holiday {
    struct JET2HOLIDAY has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<JET2HOLIDAY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<JET2HOLIDAY>>(0x2::coin::mint<JET2HOLIDAY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: JET2HOLIDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JET2HOLIDAY>(arg0, 2, b"EBH", b"Emperor Bread Head", b"Learning Sui on Move", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://framerusercontent.com/images/0KKocValgAmB9XHzcFI6tALxGGQ.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<JET2HOLIDAY>>(0x2::coin::mint<JET2HOLIDAY>(&mut v2, 30000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JET2HOLIDAY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JET2HOLIDAY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

