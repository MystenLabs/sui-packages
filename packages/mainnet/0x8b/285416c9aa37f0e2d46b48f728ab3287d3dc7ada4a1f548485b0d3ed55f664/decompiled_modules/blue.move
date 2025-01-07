module 0x8b285416c9aa37f0e2d46b48f728ab3287d3dc7ada4a1f548485b0d3ed55f664::blue {
    struct BLUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUE>(arg0, 9, b"BLUE", b"Blues Clues", b"Blue skidoo, we can too!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0x1ae42735d62a41a9f6fe180edc4aef578df99b0f.png?size=xl&key=b08176")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BLUE>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUE>>(v1);
    }

    // decompiled from Move bytecode v6
}

