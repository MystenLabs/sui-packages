module 0x200cd97949103dad6092ef55711123c63dee4311d5f2493bafe6cf9d18398b::dot {
    struct DOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOT>(arg0, 9, b"DOT", b"Dot coin", b"Dot coin is a meme token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bdcede41-3581-4c39-8f8a-1648c76c29be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

