module 0xb9fa97f963e81e079a64cc7f596e9d92dc1f5ef7311cf71da219b15da26609b0::gyan {
    struct GYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GYAN>(arg0, 6, b"GYAN", b"GYAN MUDRA TOKEN", x"57656c636f6d6520746f20746865204779616e204d7564726120756e69766572736520e280942077686572652073706972697475616c20656e65726779206d65657473206469676974616c2063757272656e63792120f09fa798e2808de29982efb88fe29ca80a0a4779616e204d756472612c2074686520616e6369656e742068616e642067657374757265206b6e6f776e20666f722069747320706f77657220746f20656e68616e636520776973646f6d2c20756e6c6f636b206b6e6f776c656467652c20616e6420656c657661746520796f7572207374617465206f66206d696e642e20466f6c6c6f7720666f72206d6f72652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731525910913.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GYAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GYAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

