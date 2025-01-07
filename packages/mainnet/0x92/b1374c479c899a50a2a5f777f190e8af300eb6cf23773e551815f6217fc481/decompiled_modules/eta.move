module 0x92b1374c479c899a50a2a5f777f190e8af300eb6cf23773e551815f6217fc481::eta {
    struct ETA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETA>(arg0, 9, b"ETA", b"Jason ETA", b"WHAT'S YOUR ETAA! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ed51d850-a8e3-4242-8d74-46ae4e08c97d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ETA>>(v1);
    }

    // decompiled from Move bytecode v6
}

