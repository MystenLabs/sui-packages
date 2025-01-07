module 0x9b28711e6960ab4ba75a59f9b8c223dea5acd8256b9e8989d911735a876ed309::sah {
    struct SAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAH>(arg0, 9, b"SAH", b"songanh", b"SHA token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3cfae4a9-7379-45af-9066-428d136634d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

