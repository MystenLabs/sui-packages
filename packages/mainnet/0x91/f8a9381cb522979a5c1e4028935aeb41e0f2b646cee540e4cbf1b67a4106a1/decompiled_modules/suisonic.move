module 0x91f8a9381cb522979a5c1e4028935aeb41e0f2b646cee540e4cbf1b67a4106a1::suisonic {
    struct SUISONIC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISONIC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISONIC>(arg0, 9, b"SUISONIC", b"Sonic6900", x"e29aa1efb88f4d6565742024536f6e6963363930302c2074686520666972737420626c756520626c7572206f6e207468652053554920636861696e2c2066756c6c206f6620656e6572677920616e642064657465726d696e6174696f6e2e202068747470733a2f2f742e6d652f536f6e6963363930305f537569202068747470733a2f2f782e636f6d2f536f6e696336393030537569202068747470733a2f2f736f6e6963363930302e73697465", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/sonic6900/sonic/refs/heads/main/12b85b7f-e710-4338-aba8-624e3314f98c.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISONIC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISONIC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISONIC>>(v1);
    }

    // decompiled from Move bytecode v6
}

