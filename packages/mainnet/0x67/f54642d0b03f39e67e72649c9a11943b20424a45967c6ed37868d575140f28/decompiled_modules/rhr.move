module 0x67f54642d0b03f39e67e72649c9a11943b20424a45967c6ed37868d575140f28::rhr {
    struct RHR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHR>(arg0, 9, b"RHR", b"Richhamste", b"New memcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6d8612e3-808c-4a3c-a8ea-ff267d2f8563.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RHR>>(v1);
    }

    // decompiled from Move bytecode v6
}

