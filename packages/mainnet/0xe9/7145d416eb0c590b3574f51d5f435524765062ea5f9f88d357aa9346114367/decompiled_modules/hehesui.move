module 0xe97145d416eb0c590b3574f51d5f435524765062ea5f9f88d357aa9346114367::hehesui {
    struct HEHESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEHESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEHESUI>(arg0, 9, b"HEHESUI", b"Hehesuioi", b"Hehesuioi is the best", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fc33d8f5-bfc9-4cde-89da-133da6b6e91d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEHESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HEHESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

