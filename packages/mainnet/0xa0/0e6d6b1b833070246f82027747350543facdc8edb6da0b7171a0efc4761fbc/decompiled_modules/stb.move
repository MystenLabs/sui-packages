module 0xa00e6d6b1b833070246f82027747350543facdc8edb6da0b7171a0efc4761fbc::stb {
    struct STB has drop {
        dummy_field: bool,
    }

    fun init(arg0: STB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STB>(arg0, 6, b"STB", b"stabase", b"stabase ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1750403866468.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

