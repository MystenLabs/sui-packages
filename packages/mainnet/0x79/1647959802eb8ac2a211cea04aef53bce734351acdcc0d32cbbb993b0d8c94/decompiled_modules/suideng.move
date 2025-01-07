module 0x791647959802eb8ac2a211cea04aef53bce734351acdcc0d32cbbb993b0d8c94::suideng {
    struct SUIDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDENG>(arg0, 6, b"SUIDENG", b"SUI DENG", x"5468652068696c6172696f75736c7920636c75656c65737320686970706f2077686f20616c77617973206765747320696e746f207269646963756c6f7573206a756e676c65206d6973686170732120f09fa69bf09f92ab0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731009002864.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIDENG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDENG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

