module 0x1601b786315e8648469e246add35769f73f8fb3733c577d3bbb3e04dc3b81ea0::bfo {
    struct BFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFO>(arg0, 9, b"BFO", b"blue", b"BLUE FLOWER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/691cc8a2-af61-43a3-9ab5-6f3dd7806b46.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BFO>>(v1);
    }

    // decompiled from Move bytecode v6
}

