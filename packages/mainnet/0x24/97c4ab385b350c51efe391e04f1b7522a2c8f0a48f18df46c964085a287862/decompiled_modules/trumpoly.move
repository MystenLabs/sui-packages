module 0x2497c4ab385b350c51efe391e04f1b7522a2c8f0a48f18df46c964085a287862::trumpoly {
    struct TRUMPOLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPOLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPOLY>(arg0, 9, b"TRUMPOLY", b"TRUMPOLY ON SUI", b"Make America great again with $TRUMPOLY!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmZmdcgbXzrHTPAyG64CrotPJWC9UpxndFrRZZqwiCrETR")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TRUMPOLY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPOLY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPOLY>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

