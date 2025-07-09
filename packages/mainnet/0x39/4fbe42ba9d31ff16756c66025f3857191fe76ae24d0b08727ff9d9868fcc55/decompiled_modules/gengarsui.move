module 0x394fbe42ba9d31ff16756c66025f3857191fe76ae24d0b08727ff9d9868fcc55::gengarsui {
    struct GENGARSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GENGARSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GENGARSUI>(arg0, 9, b"GENSUI", b"Gengarsui", b"A mischievous phantom with a big meme grin, shadowy Sui droplets swirling around.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreidgbaxjx4ixaz65ut6l2tmfm343fcm4kl6arypkvl7ybcfsosi6bu")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GENGARSUI>(&mut v2, 1000000000000000000, @0x4c269af1a93409f39027fb2b8847924597d0e03d93ce33e7e0e94d098b0f0885, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GENGARSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GENGARSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

