module 0x67a175e4c04aaaefe8a868e1eaeacbdef2c9e8128dea69b1f83ccabab22c1db2::pkf {
    struct PKF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKF>(arg0, 9, b"PKF", b"POCKETFI", b"POCKETFI BOT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/175243bc-4b66-452d-9900-a769636e9237.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PKF>>(v1);
    }

    // decompiled from Move bytecode v6
}

