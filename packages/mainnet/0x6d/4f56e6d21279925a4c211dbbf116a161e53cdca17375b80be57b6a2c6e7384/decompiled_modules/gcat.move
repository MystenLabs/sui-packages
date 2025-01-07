module 0x6d4f56e6d21279925a4c211dbbf116a161e53cdca17375b80be57b6a2c6e7384::gcat {
    struct GCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GCAT>(arg0, 9, b"GCAT", b"GrannyCat ", b"A meme coin set to do 500x like WEWE is projected to do. Not plenty with a TS of 5 million. Don't snitch BUY now before it's limited.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9c0da546-4795-4450-8159-acd4cc0719d2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

