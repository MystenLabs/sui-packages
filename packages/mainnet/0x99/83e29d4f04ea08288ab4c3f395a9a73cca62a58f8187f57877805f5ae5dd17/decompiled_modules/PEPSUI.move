module 0x9983e29d4f04ea08288ab4c3f395a9a73cca62a58f8187f57877805f5ae5dd17::PEPSUI {
    struct PEPSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPSUI>(arg0, 2, b"PEPSUI", b"PEPSUI", b"Soda water of SUI, https://www.pepsui.xyz/, https://t.me/PEPSUI_Onsui, https://x.com/pepsui_", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/vHWPKyBv/pepsuiconpack.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPSUI>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PEPSUI>(&mut v2, 95000000000, @0x77933b958fe721416c2189fc08cfcd89fdf08c7d549c72d4df64351ef9629896, arg1);
        0x2::coin::mint_and_transfer<PEPSUI>(&mut v2, 5000000000, @0xb9a54079894b16c912381cd0b5e6f3cfebee54c1218ddcd19c24ba82c0162963, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPSUI>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

