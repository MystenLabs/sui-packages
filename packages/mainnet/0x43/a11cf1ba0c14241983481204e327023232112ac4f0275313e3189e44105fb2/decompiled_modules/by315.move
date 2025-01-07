module 0x43a11cf1ba0c14241983481204e327023232112ac4f0275313e3189e44105fb2::by315 {
    struct BY315 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BY315, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BY315>(arg0, 9, b"BY315", b"", b"Artificial Intelligence, Creating the Future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c8e9b9fe-85a0-40e0-9a2f-808dbc2b2ee9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BY315>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BY315>>(v1);
    }

    // decompiled from Move bytecode v6
}

