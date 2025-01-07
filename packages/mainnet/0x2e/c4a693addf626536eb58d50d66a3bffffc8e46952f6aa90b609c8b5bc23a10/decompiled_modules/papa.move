module 0x2ec4a693addf626536eb58d50d66a3bffffc8e46952f6aa90b609c8b5bc23a10::papa {
    struct PAPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPA>(arg0, 6, b"PAPA", b"Papa", x"d0b4d0bed0bcd0b5d0bd20d0b5d0b1d0b5d0b9d188d0b8d0b90a0a54686520426f7373206f66207468652053756920426c6f636b636861696e0a0a4d65657420706170612c20746865206d61737465726d696e6420726561647920746f20646f6d696e617465207468652053756920626c6f636b636861696e207363656e652e2057697468207374726565742d736d61727420737472617465677920616e6420756e6d61746368656420696e666c75656e63652c207061706127732061626f757420746f2074616b65206f76657220616e6420736574206e65772072756c657320696e207468652067616d652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731452582944.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAPA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

