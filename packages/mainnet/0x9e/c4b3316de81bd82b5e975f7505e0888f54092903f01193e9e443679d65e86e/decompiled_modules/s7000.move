module 0x9ec4b3316de81bd82b5e975f7505e0888f54092903f01193e9e443679d65e86e::s7000 {
    struct S7000 has drop {
        dummy_field: bool,
    }

    fun init(arg0: S7000, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S7000>(arg0, 9, b"S7000", b"It's Over 7000!", x"5468657920746f6c642075732061626f757420376b2077617320676f6e6e6120626520746865206c696d69742e2042757420766567657461206a75737420666f756e64206f75742074686174206974e2809973206f766572203730303021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/18f6a5d85d66b365847ddbcc2d12dabbblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<S7000>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S7000>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

