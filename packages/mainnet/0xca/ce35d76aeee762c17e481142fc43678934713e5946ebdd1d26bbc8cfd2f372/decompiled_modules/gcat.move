module 0xcace35d76aeee762c17e481142fc43678934713e5946ebdd1d26bbc8cfd2f372::gcat {
    struct GCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GCAT>(arg0, 9, b"GCAT", b"GrannyCat ", b"A meme coin set to do 500x like WEWE is projected to do. Not plenty with a TS of 5 million. Don't snitch BUY now before it's limited.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2a05616a-cc54-4b73-83ed-8f862938eccd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

