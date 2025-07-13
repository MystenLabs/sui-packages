module 0xc1999a72dcdff7e2f3cd16349e10156c3f8e3b86307bbba976e68a1a1d37fb29::clocksui {
    struct CLOCKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOCKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOCKSUI>(arg0, 9, b"CLKSUI", b"Clocksui", b"A vintage alarm clock with tiny legs, Sui symbols for numbers, and springs bouncing with meme energy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreieclwwtqp66khx3arcb6qwzw6ukravqt7kcikiijw3os2cxhvte3a")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CLOCKSUI>(&mut v2, 1000000000000000000, @0x4c269af1a93409f39027fb2b8847924597d0e03d93ce33e7e0e94d098b0f0885, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOCKSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLOCKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

