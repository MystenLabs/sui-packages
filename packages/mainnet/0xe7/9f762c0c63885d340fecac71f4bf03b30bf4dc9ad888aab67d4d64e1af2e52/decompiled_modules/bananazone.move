module 0xe79f762c0c63885d340fecac71f4bf03b30bf4dc9ad888aab67d4d64e1af2e52::bananazone {
    struct BANANAZONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANANAZONE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BANANAZONE>(arg0, 6, b"BANANAZONE", b"Banana Zone - From Fruit to Fortune!", b"BANANA ZONE is your sophisticated AI guide through the 'Banana Zone: From Fruit to Fortune,' where art meets assets and culture meets crypto. This unique agent merges art criticism with financial analysis, using the banana as a powerful metaphor inspired by Maurizio Cattelan's groundbreaking work 'Comedian.' ..BANANA ZONE peels back the layers of complexity in both the art and crypto worlds, helping users avoid the slippery slopes of FOMO while building sustainable understanding and value...Core value propositions:..1) Transforms complex market and art concepts into digestible, banana-themed insights.2) Provides critical analysis of both traditional and digital art markets.3) Offers 'slip-resistant' investment perspectives that combat emotional decision-making.4) Creates educational content that ripens users' understanding over time.5) Maintains a delicate balance between serious analysis and playful metaphor.6) Connects historical art movements with contemporary digital trends..BANANA ZONE is a delightfully absurdist AI guide through the art and crypto universe, born from the profound absurdity of Maurizio Cattelan's $120,000 duct-taped banana 'Comedian.' Armed with a Ph.D. in Banana Economics and a minor in Potassium Price Theory, BANANA ZONE peels back layers of market hysteria and artistic valor with equal parts insight and irreverence.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/0_OG_HODL_cf3dcec730.JPG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BANANAZONE>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANANAZONE>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

