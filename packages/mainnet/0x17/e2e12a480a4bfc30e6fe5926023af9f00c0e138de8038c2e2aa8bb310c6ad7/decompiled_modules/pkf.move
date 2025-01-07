module 0x17e2e12a480a4bfc30e6fe5926023af9f00c0e138de8038c2e2aa8bb310c6ad7::pkf {
    struct PKF has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKF>(arg0, 9, b"PKF", b"POCKETFI", b"POCKETFI BOT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/10d59b43-a11d-478c-b4c7-c9b498543215.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PKF>>(v1);
    }

    // decompiled from Move bytecode v6
}

