module 0x45cffbc4051f0ae3f774db5908322ecf55eb6d3b3c1bffc82f88bf245b0e7810::suiggabutt {
    struct SUIGGABUTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGGABUTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGGABUTT>(arg0, 6, b"Suiggabutt", b"Suigga Butt", b"Suigga Tyson ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731745873211.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIGGABUTT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGGABUTT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

