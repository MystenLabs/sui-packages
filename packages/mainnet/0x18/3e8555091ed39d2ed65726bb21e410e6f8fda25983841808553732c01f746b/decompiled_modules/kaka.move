module 0x183e8555091ed39d2ed65726bb21e410e6f8fda25983841808553732c01f746b::kaka {
    struct KAKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAKA>(arg0, 9, b"KAKA", b"Kakalot", b"Kakalot is dragon meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3893f6bf-2265-4aaf-a540-0b95f8e1427c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

