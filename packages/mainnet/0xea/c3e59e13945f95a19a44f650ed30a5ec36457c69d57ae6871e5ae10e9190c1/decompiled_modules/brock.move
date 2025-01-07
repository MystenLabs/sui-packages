module 0xeac3e59e13945f95a19a44f650ed30a5ec36457c69d57ae6871e5ae10e9190c1::brock {
    struct BROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROCK>(arg0, 9, b"BROCK", b"BlackRock", b"First memcoin frome BLACKROCK. BUY TODAY - SELL TOMORROW. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d94faf8a-9ed9-4d3f-9971-674b056a1de8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BROCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

