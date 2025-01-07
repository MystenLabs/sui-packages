module 0xd409a068b0238281bb56a191291afeefc8d580abe6a86371fc495c1c99ea023c::brock {
    struct BROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BROCK>(arg0, 9, b"BROCK", b"BlackRock", b"First memcoin frome BLACKROCK. BUY TODAY - SELL TOMORROW. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5de09b15-5f91-43fa-8a2f-20556966ee85.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BROCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BROCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

