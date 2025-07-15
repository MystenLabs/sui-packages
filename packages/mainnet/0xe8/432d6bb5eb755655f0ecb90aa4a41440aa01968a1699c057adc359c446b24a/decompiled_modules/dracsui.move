module 0xe8432d6bb5eb755655f0ecb90aa4a41440aa01968a1699c057adc359c446b24a::dracsui {
    struct DRACSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRACSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRACSUI>(arg0, 9, b"DRASUI", b"Dracsui", b"A sleek, dragonfly-like beast with holographic Sui wings, streaking through meme space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreiadbfhvjb2jvffj5cvrsrvg63q4tjbzkjoii73pri3nirjuygeuhy")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DRACSUI>(&mut v2, 1000000000000000000, @0x4c269af1a93409f39027fb2b8847924597d0e03d93ce33e7e0e94d098b0f0885, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRACSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DRACSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

