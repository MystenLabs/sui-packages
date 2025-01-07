module 0x6b35f9772e8caa4af90a8091580ae76fd5773da613c580ada25d5695982c5099::eta {
    struct ETA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETA>(arg0, 9, b"ETA", b"Jason ETA", b"WHAT'S YOUR ETAA! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3364acc3-9403-410c-bb0b-d2001af8220c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ETA>>(v1);
    }

    // decompiled from Move bytecode v6
}

