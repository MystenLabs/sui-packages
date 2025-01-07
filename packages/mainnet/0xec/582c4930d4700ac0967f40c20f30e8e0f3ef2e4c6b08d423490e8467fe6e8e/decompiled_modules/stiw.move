module 0xec582c4930d4700ac0967f40c20f30e8e0f3ef2e4c6b08d423490e8467fe6e8e::stiw {
    struct STIW has drop {
        dummy_field: bool,
    }

    fun init(arg0: STIW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STIW>(arg0, 6, b"STIW", b"STILL SUI", x"7374696c6c2077617465722e202e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/55ceb0_0729034631c6475e9587cc3e34436562_mv2_de83816fba.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STIW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STIW>>(v1);
    }

    // decompiled from Move bytecode v6
}

