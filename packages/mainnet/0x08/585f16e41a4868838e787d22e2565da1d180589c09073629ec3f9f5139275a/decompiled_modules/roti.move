module 0x8585f16e41a4868838e787d22e2565da1d180589c09073629ec3f9f5139275a::roti {
    struct ROTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROTI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROTI>(arg0, 9, b"ROTI", b"Roti", b"daily chapati ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e5824ce6-f083-470a-a48d-1a59fe802feb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROTI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROTI>>(v1);
    }

    // decompiled from Move bytecode v6
}

