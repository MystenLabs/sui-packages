module 0xf0345a4535e53923247cc20073403ae61abab1a2b141ec53ad9b70bac5eaa1fe::pweng {
    struct PWENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWENG>(arg0, 9, b"PWENG", b"Pweng", b"Pay back is a pweng !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/BwFLAzM1syXYCN7AjgAcHWvtsUzKjsyFGm7osxgXpump.png?size=xl&key=a28644")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PWENG>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWENG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PWENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

