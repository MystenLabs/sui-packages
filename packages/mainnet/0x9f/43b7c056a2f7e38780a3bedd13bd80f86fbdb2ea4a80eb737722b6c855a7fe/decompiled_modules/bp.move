module 0x9f43b7c056a2f7e38780a3bedd13bd80f86fbdb2ea4a80eb737722b6c855a7fe::bp {
    struct BP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BP>(arg0, 9, b"BP", b"Btc Pump", b"Pump to New Ath", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9884e16c-1669-4d27-a4e9-2ff2bf6548f9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BP>>(v1);
    }

    // decompiled from Move bytecode v6
}

