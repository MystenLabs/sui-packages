module 0xd6a6ffbee4ef4def391833134b55bb118ffe79e93f9455ee10da710aa6995f92::ISUI {
    struct ISUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ISUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ISUI>(arg0, 9, b"ISUI", b"ISUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ISUI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ISUI>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<ISUI>>(0x2::coin::mint<ISUI>(&mut v2, 1100000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

