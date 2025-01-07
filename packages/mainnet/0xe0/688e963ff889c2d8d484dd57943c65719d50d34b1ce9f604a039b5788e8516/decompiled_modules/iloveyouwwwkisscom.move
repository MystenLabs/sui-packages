module 0xe0688e963ff889c2d8d484dd57943c65719d50d34b1ce9f604a039b5788e8516::iloveyouwwwkisscom {
    struct ILOVEYOUWWWKISSCOM has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ILOVEYOUWWWKISSCOM>, arg1: 0x2::coin::Coin<ILOVEYOUWWWKISSCOM>) {
        0x2::coin::burn<ILOVEYOUWWWKISSCOM>(arg0, arg1);
    }

    fun init(arg0: ILOVEYOUWWWKISSCOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ILOVEYOUWWWKISSCOM>(arg0, 9, b"i love you www.kiss.com", b"kiss", b"description of kiss token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suiscan.xyz/static/media/suiCoinLogo.b3b77ca65ac4f170e7e075732ea93352.svg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ILOVEYOUWWWKISSCOM>>(v1);
        0x2::coin::mint_and_transfer<ILOVEYOUWWWKISSCOM>(&mut v2, 210000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ILOVEYOUWWWKISSCOM>>(v2, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<ILOVEYOUWWWKISSCOM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ILOVEYOUWWWKISSCOM>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

