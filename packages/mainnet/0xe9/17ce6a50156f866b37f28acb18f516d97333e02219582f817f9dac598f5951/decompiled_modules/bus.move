module 0xe917ce6a50156f866b37f28acb18f516d97333e02219582f817f9dac598f5951::bus {
    struct BUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUS>(arg0, 9, b"BUS", b"BUMS ", b"BUMS IS THE FIRST MEME COINS IN SUI NETWORK ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6eb8d735-03d2-4abe-bb99-9896e368b591.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

