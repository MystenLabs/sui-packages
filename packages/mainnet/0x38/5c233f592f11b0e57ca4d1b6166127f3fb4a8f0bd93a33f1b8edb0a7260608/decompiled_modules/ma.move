module 0x385c233f592f11b0e57ca4d1b6166127f3fb4a8f0bd93a33f1b8edb0a7260608::ma {
    struct MA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MA>(arg0, 9, b"MA", b"MAMA", x"4a6f696e20746865204d414d4120546f6b656e206d6f76656d656e7420746f206d616b65206120646966666572656e63652c2063656c656272617465206d6f74686572686f6f642c20616e64206275696c64206120627269676874657220667574757265207768657265206576657279206d6f6d206665656c732076616c75656420616e6420737570706f727465642e20546f6765746865722c206c6574e280997320737072656164206c6f766520616e6420677261746974756465e280946f6e6520746f6b656e20617420612074696d652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/64fb3668-07b4-4ce3-831a-b76ff2cc7db7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MA>>(v1);
    }

    // decompiled from Move bytecode v6
}

