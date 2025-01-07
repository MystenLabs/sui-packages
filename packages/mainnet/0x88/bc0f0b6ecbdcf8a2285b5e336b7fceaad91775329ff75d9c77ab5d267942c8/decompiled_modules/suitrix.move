module 0x88bc0f0b6ecbdcf8a2285b5e336b7fceaad91775329ff75d9c77ab5d267942c8::suitrix {
    struct SUITRIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITRIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITRIX>(arg0, 6, b"SUItrix", b"suiTRIX", x"5355492c2074686520776174657220636861696e2c20697320546865204f6e650a0a476574206f7574206f6620746865206f6c6420426c6f636b636861696e20616e64206a6f696e20546865204f6e652c20207468697320206973206120717565737420746f206d616b652075732072696368206c696b652077617465720a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_20241013_140142_d62072f31c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITRIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITRIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

