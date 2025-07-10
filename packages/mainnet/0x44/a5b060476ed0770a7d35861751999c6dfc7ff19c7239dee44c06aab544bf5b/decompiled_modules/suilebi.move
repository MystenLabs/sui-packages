module 0x44a5b060476ed0770a7d35861751999c6dfc7ff19c7239dee44c06aab544bf5b::suilebi {
    struct SUILEBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILEBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILEBI>(arg0, 9, b"SUIBI", b"Suilebi", b"A small, mystical sprite with leafy antennae, floating inside a glowing Sui bubble.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreicfgbl5kq5gc7fcnv7u37x2c3qnxew4xaph2b5g4bwneulm72yvlu")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUILEBI>(&mut v2, 1000000000000000000, @0x4c269af1a93409f39027fb2b8847924597d0e03d93ce33e7e0e94d098b0f0885, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILEBI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILEBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

