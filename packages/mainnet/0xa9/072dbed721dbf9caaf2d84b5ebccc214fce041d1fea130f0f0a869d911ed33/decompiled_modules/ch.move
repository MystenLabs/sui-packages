module 0xa9072dbed721dbf9caaf2d84b5ebccc214fce041d1fea130f0f0a869d911ed33::ch {
    struct CH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CH>(arg0, 9, b"CH", b"Chilli", b"Meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/977ca50b-2764-4cbd-b56f-f3c252d4b4da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CH>>(v1);
    }

    // decompiled from Move bytecode v6
}

