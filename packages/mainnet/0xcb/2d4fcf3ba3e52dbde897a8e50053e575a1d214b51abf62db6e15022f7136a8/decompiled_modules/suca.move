module 0xcb2d4fcf3ba3e52dbde897a8e50053e575a1d214b51abf62db6e15022f7136a8::suca {
    struct SUCA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUCA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUCA>(arg0, 6, b"SUca", b"SUItcase", x"4e6f20736f6369616c206d656469610a4e6f20776562736974650a0a59455421", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000010758_383bb65ab7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUCA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUCA>>(v1);
    }

    // decompiled from Move bytecode v6
}

