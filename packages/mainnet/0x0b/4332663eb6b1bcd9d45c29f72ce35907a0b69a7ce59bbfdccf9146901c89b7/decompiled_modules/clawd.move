module 0xb4332663eb6b1bcd9d45c29f72ce35907a0b69a7ce59bbfdccf9146901c89b7::clawd {
    struct CLAWD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLAWD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAWD>(arg0, 9, b"CLAWD", b"Clawdbot", b"Clawdbot token on Sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://image2url.com/r2/default/images/1769593541813-51d8f342-58f5-461b-a99c-62303d168437.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CLAWD>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLAWD>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CLAWD>>(v2);
    }

    // decompiled from Move bytecode v6
}

