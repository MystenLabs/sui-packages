module 0x7fd2a0648c103a97d74ba2b80050657e8b826a4ffc096a63d21e7fe0e349bfff::har {
    struct HAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAR>(arg0, 9, b"HAR", b"HARD ", b"HARD WORKER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9382b738-c092-461d-9186-b451adbe9da9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

