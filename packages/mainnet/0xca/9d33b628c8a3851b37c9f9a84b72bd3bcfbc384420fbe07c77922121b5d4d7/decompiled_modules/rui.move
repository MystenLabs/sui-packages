module 0xca9d33b628c8a3851b37c9f9a84b72bd3bcfbc384420fbe07c77922121b5d4d7::rui {
    struct RUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RUI>(arg0, 9, b"RUI", b"Ruimia", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/65a9b0df-ed8f-47bf-a640-fd3fa90be97f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

