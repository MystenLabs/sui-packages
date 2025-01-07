module 0x606acf4d1a0bbdc90a26d2449a74c1e436773b7945e1e2118495485d9c6feddf::tnx {
    struct TNX has drop {
        dummy_field: bool,
    }

    fun init(arg0: TNX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TNX>(arg0, 9, b"TNX", b"The Next 100x Memecoin On Sui", b"TN100x is \"The Next 100x Memecoin on Sui\". Born on Warpcast and backed by a community of over 5,000 degens. Join us in the /lp channel on Warpcast and learn more about Community Points, Liquidity Mining, and The Based LP NFT at based.thelp.xyz.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x5b5dee44552546ecea05edea01dcd7be7aa6144a.png?size=xl&key=de70f1")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TNX>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TNX>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TNX>>(v1);
    }

    // decompiled from Move bytecode v6
}

