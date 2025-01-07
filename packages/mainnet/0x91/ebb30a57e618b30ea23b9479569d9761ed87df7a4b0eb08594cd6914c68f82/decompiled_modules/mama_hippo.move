module 0x91ebb30a57e618b30ea23b9479569d9761ed87df7a4b0eb08594cd6914c68f82::mama_hippo {
    struct MAMA_HIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAMA_HIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAMA_HIPPO>(arg0, 9, b"MAMA HIPPO", b"MAMA HIPPO", b"In their own way, hippos are as terrifying as dragons.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/sui/0x02e3a67430484f4858c7e95c1a8ac5189fb256b76c72922ffb425cdf6dc35f49::hippo::hippo.png?size=lg&key=c2b539")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MAMA_HIPPO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAMA_HIPPO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MAMA_HIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

