module 0x5378ccbc0ae56250e35d3f3711671009a05a136cfd2f6d91d9e2ada1f41b5baf::bigbrain {
    struct BIGBRAIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGBRAIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGBRAIN>(arg0, 9, b"BIGBRAIN", b"BigBrain", x"4a6f696e20536f6c61726e612043726f6674202d204d6f6f6e2052616964657220244d4f4f4e5220746865206e6f2e31206d656d65206f6e205375692e20496e20736561726368206f66206e6577206d6f6f6e7320746f207261696420746869732070756d70746f62657220f09f9a80f09f92b0", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/solana/J9zjM2nn4DBYpFy3qrReaUzY66g4EFMwLa61YSGCpump.png?size=xl&key=a21cac")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BIGBRAIN>(&mut v2, 3000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGBRAIN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIGBRAIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

