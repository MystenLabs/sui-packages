module 0xd134c453db59cc48efb5491219eb2c51f61279af38aba2f41b5cafb3db362e52::ctl {
    struct CTL has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTL>(arg0, 6, b"CTL", b"Citadel AI", x"4f757220666c6167736869702070726f647563742c2042617265204d6574616c20736572766572732c2069732064657369676e656420746f2064656c6976657220756e6d6174636865642073656375726974792c20666c65786962696c6974792c20616e6420706572666f726d616e63652e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737686045720.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CTL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

