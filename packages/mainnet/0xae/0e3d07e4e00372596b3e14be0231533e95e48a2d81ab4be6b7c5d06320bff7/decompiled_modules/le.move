module 0xae0e3d07e4e00372596b3e14be0231533e95e48a2d81ab4be6b7c5d06320bff7::le {
    struct LE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LE>(arg0, 9, b"LE", b"Lion eyes", b"Unshakable and fearless ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c2b81a5e-f636-48bd-8bb8-9a150304c06b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LE>>(v1);
    }

    // decompiled from Move bytecode v6
}

