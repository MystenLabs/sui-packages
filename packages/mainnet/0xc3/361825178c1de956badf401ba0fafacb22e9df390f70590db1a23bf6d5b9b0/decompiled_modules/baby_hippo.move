module 0xc3361825178c1de956badf401ba0fafacb22e9df390f70590db1a23bf6d5b9b0::baby_hippo {
    struct BABY_HIPPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABY_HIPPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABY_HIPPO>(arg0, 9, b"BABY HIPPO", b"BABY HIPPO", b"In their own way, hippos are as terrifying as dragons.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/sui/0x02e3a67430484f4858c7e95c1a8ac5189fb256b76c72922ffb425cdf6dc35f49::hippo::hippo.png?size=lg&key=c2b539")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BABY_HIPPO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABY_HIPPO>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABY_HIPPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

