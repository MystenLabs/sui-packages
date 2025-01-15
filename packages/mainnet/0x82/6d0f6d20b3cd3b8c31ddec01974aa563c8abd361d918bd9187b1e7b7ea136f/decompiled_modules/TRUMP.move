module 0x826d0f6d20b3cd3b8c31ddec01974aa563c8abd361d918bd9187b1e7b7ea136f::TRUMP {
    struct TRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMP>(arg0, 9, b"TRUMP", b"TRUMP", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://caposui.xyz/assets/img/nobgcapo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMP>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TRUMP>>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<TRUMP>>(0x2::coin::mint<TRUMP>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

