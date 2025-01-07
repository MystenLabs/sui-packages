module 0xb03fda062d1e5c0b3a6cf2f92448c0d4e35c0bda223dd4c64b402f8b4b7416e1::boe {
    struct BOE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOE>(arg0, 9, b"BOE", b"BEYONCE", b"Meme beyonce", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d6a2b6b5-38c4-43d1-9070-ee1185fb2c34.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOE>>(v1);
    }

    // decompiled from Move bytecode v6
}

