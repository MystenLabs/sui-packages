module 0x1c6010bfcc7449f8fee957a9d00f9cc7d87a818a3fdc79a6702dff8e14702b82::cmusk {
    struct CMUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CMUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CMUSK>(arg0, 9, b"CMUSK", b"CyberMusk", b"$cmusk: egg-handler, space-dancer, shirt-folder.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/DTqXXWwnRV2Sa2aJhHx1hFWvLd9sCeT1u9ziDidZpump/header.png?size=xl&key=28817e")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CMUSK>(&mut v2, 2000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CMUSK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CMUSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

