module 0x1cdb3ae91b51d1382f77e673ad3344b9baf47547da89c210161020b71767b513::memezgg {
    struct MEMEZGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEMEZGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEMEZGG>(arg0, 6, b"MemezGG", b"Memez.GG", x"4d656d657a2e67672041676772656761746f72206973204c697665210a0ae380805765e28099726520746872696c6c656420746f20616e6e6f756e63652074686520756c74696d6174652061676772656761746f72206f6e207468652024537569204e6574776f726b2e200a596f75e2809972652077656c636f6d6520e280942047472e0a0a4265206f6e206120726f6c6c2c206265206f6e206120726f6c6c2d204d656d657a4747", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730967803126.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEMEZGG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEMEZGG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

