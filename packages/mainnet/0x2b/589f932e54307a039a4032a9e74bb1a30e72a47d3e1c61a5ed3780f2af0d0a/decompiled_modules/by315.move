module 0x2b589f932e54307a039a4032a9e74bb1a30e72a47d3e1c61a5ed3780f2af0d0a::by315 {
    struct BY315 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BY315, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BY315>(arg0, 9, b"BY315", b"YAI", b"Artificial Intelligence, Creating the Future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/777cbbcf-af77-45c5-9953-3e8c3c1fff78.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BY315>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BY315>>(v1);
    }

    // decompiled from Move bytecode v6
}

