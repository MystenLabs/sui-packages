module 0x3c2fb0f4ea7aa5f1eeedadf0136259447ef99853182a5d7ad53a2fab5d9cc41d::soomer {
    struct SOOMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOOMER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOOMER>(arg0, 9, b"SOOMER", b"SUI SOOMER", b"SOOMER represents a new dawn for SUI enthusiasts: https://soomeronsui.fun - https://t.me/SomerSui_Portal - https://x.com/Somer_Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.soomeronsui.fun/logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SOOMER>(&mut v2, 100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOOMER>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SOOMER>>(v1);
    }

    // decompiled from Move bytecode v6
}

