module 0x6bedb786d22c5e6f39e7d12d69e24eb5d92291fbb10f55205b1eae471aa32461::bc {
    struct BC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BC>(arg0, 9, b"BC", b"Bag Coin", b"Bag", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2e97dd79-490e-4acb-9572-586262caa7af.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BC>>(v1);
    }

    // decompiled from Move bytecode v6
}

