module 0x6bef4ee123ffc0132843ba68e150079d68c76307bc27590b99ec6840876be839::ssui {
    struct SSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSUI>(arg0, 9, b"sSUI", b"solSUI", b"SUI on Solana", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cryptologos.cc/logos/sui-sui-logo.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SSUI>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSUI>>(v2, @0xaa31f81c2bed7bd2a1fa448975aa4fd13045fad07aec79492aff00e35354df00);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

