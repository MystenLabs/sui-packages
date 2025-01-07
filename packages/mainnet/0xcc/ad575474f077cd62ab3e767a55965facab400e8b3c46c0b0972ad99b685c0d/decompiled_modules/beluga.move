module 0xccad575474f077cd62ab3e767a55965facab400e8b3c46c0b0972ad99b685c0d::beluga {
    struct BELUGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BELUGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BELUGA>(arg0, 9, b"BELUGA", b"Beluga", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/2U8yoWz.png"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BELUGA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BELUGA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BELUGA>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

