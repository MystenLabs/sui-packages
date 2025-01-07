module 0x90b7fbe6627ad1947f8597a9ad03f537759aded67a850d9f4bee7d1213cf3f58::nanai {
    struct NANAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NANAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NANAI>(arg0, 9, b"NANAI", b"NANANI", b"THAT GO WHEN TO GO STOP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d111c4de-3e21-4022-ab68-0f9d0d682fbb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NANAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NANAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

