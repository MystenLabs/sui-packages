module 0xe69e024517a6b60497493aef640e82252b442a92af7b8785b1a340273d63cab1::harl {
    struct HARL has drop {
        dummy_field: bool,
    }

    fun init(arg0: HARL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HARL>(arg0, 9, b"HARL", b"MORIN HARR", b"morrin and harrimas is meme token from indonesia", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3dc4e585-4edf-43c9-98fd-3a01144abf97.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HARL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HARL>>(v1);
    }

    // decompiled from Move bytecode v6
}

