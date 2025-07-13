module 0x60e70ff4f3348acf181cc0d5908e14e069f8935ee3a573e7fa8758883e9f85a6::robotsui {
    struct ROBOTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROBOTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROBOTSUI>(arg0, 9, b"RBTSUI", b"Robotsui", b"A cute retro robot with a Sui screen for a face, antenna beeping, and coin-slot chest dispensing tokens.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreiadxbycq7s6jqynh55rhzgq5wv2e2vromgvvigr4xoyiysynjahkm")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ROBOTSUI>(&mut v2, 1000000000000000000, @0x4c269af1a93409f39027fb2b8847924597d0e03d93ce33e7e0e94d098b0f0885, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROBOTSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ROBOTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

