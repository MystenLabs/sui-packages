module 0xab77c28e7a63bed44e9e67f0a7d2638915bcc993a13f3bfb590e0e2eeb36acfe::circle {
    struct CIRCLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIRCLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIRCLE>(arg0, 9, b"Circle", b"GOT EM", b"You knew them rules, if you look you are compelled to buy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/DU6eKdghQCiSmPJ9gUpecR9T7ufMmaBBCS3d77bspump.png?size=xl&key=472bf8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CIRCLE>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CIRCLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIRCLE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

