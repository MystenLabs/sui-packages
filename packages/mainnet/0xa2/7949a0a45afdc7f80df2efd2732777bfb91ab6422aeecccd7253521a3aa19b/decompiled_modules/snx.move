module 0xa27949a0a45afdc7f80df2efd2732777bfb91ab6422aeecccd7253521a3aa19b::snx {
    struct SNX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNX>(arg0, 9, b"SNX", b"Sanx", b"Sanx adalah coin buatan san", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/96507219-e53c-4ef7-a5a0-dd42a4609f86.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNX>>(v1);
    }

    // decompiled from Move bytecode v6
}

