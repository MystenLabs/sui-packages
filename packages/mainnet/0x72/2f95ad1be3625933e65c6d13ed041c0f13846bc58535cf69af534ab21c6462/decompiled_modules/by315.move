module 0x722f95ad1be3625933e65c6d13ed041c0f13846bc58535cf69af534ab21c6462::by315 {
    struct BY315 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BY315, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BY315>(arg0, 9, b"BY315", b"AIY", b"Artificial Intelligence, Creating the Future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/94c27c4b-c411-4b96-ae2a-e079e6cdc46f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BY315>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BY315>>(v1);
    }

    // decompiled from Move bytecode v6
}

