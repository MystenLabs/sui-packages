module 0x85aa82161047a06f1c99a1c072b508a73729efbdbd21893eef553524be3244c8::frog {
    struct FROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROG>(arg0, 6, b"FROG", b"FROG on turbos", x"545552424f53205448452046524f470a22566963746f72696f75732077617272696f72732077696e20666972737420616e64207468656e20676f20746f207761722c207768696c652064656665617465642077617272696f727320676f20746f2077617220666972737420616e64207468656e207365656b20746f2077696e2e222053756e20547a752c2054686520417274206f66205761722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731076804979.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FROG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

