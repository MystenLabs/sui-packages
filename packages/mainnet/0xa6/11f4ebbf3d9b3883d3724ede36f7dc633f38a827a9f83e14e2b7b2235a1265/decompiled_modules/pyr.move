module 0xa611f4ebbf3d9b3883d3724ede36f7dc633f38a827a9f83e14e2b7b2235a1265::pyr {
    struct PYR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PYR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PYR>(arg0, 9, b"PYR", b"PYR Token", b"Vulcan Forged is a non-fungible token (NFT) game studio, marketplace and dApp incubator with multiple games and an active community of users.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dexscreener.com/fetch?src=https%3A%2F%2Fcoin-images.coingecko.com%2Fcoins%2Fimages%2F14770%2Flarge%2F1617088937196.png%3F1696514439")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PYR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<PYR>>(0x2::coin::mint<PYR>(&mut v2, 10000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PYR>>(v2);
    }

    // decompiled from Move bytecode v6
}

