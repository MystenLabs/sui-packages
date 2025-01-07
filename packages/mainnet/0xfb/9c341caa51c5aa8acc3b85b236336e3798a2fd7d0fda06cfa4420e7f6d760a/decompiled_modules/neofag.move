module 0xfb9c341caa51c5aa8acc3b85b236336e3798a2fd7d0fda06cfa4420e7f6d760a::neofag {
    struct NEOFAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEOFAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEOFAG>(arg0, 6, b"NEOFAG", b"NEOFAG COIN", b"sus with men & boys since 2000 bc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://lavender-gentle-primate-223.mypinata.cloud/ipfs/QmS8ZMmYpWYg6AxdcEt4KG2Go7uvGaRvB8yB7tbw2XoNgH?pinataGatewayToken=M45Jh03NicrVqTZJJhQIwDtl7G6fGS90bjJiIQrmyaQXC_xXj4BgRqjjBNyGV7q2")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NEOFAG>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEOFAG>>(v2, @0x96c92cdfa5e0acef4792591582d84f49a06d1ddb92f0c7ef073cc28fdbb3d22e);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEOFAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

