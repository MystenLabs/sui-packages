module 0x504f2154dae2080bb3b9593f20b063fb27440925a79e4f7cb2e82e7be8645fbb::blub {
    struct BLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUB>(arg0, 9, b"BLUB", b"BLUB", b"$BLUB is the ultimate choice for those seeking the version of Pepe on the Sui network. If you're into Boys Club and edgy cryptocurrencies that break all the rules with high growth potential, $BLUB is the most badass fish in the Sui Ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/sui/0xfa7ac3951fdca92c5200d468d31a365eb03b2be9936fde615e69f0c1274ad3a0::blub::blub.png?size=xl&key=015554")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLUB>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUB>>(v2, @0xa85129f31a050e4cdfd67d8e7eaf8d943761def0dab2f2e8fe92170fbe88e51);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

