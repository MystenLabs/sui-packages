module 0x5205c31964903e68408e5a4bc08b5d4a503d477ee1a75b946504dba3a65fa8a1::fis {
    struct FIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FIS>(arg0, 9, b"FIS", b"Ngua Fish", b"Token meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a19e89bb-2c03-4dfd-899c-9484f2c568f6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

