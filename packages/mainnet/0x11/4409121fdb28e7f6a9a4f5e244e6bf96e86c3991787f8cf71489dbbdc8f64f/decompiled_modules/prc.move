module 0x114409121fdb28e7f6a9a4f5e244e6bf96e86c3991787f8cf71489dbbdc8f64f::prc {
    struct PRC has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRC>(arg0, 9, b"PRC", b"PORNOCOIN", b"Great Crypto-monnaies to buy the porno service", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/13727fe1-3bec-422e-9670-49d78561634e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRC>>(v1);
    }

    // decompiled from Move bytecode v6
}

