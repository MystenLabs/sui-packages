module 0xbbdd6e9e0b08a383f623c79d5b82d168b9fb795275338ad5a3c9243d5dc8a1a4::cct {
    struct CCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCT>(arg0, 9, b"CCT", b"big city", b"full of frost", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/530b8b28-413c-4da1-a978-c204da888920.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

