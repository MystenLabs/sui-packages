module 0xc163ce2de07e326975edd5901e5dc1653996669394d4b74b46c93fae13137424::odor {
    struct ODOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ODOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ODOR>(arg0, 6, b"Odor", b"Theodorsui", b"Scams fade. Liquidity dries. But the smell lingers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihe53rsxsfb36m5hy5hyumx3odras3fzewnikuq3huexbfihaeioe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ODOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<ODOR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

