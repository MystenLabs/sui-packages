module 0x2ca28aefd87920fe522e5bc29c78e535c9ab843b37904bd9f4976ac986e1130a::wowo {
    struct WOWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOWO>(arg0, 9, b"WOWO", b"WOWO MEMES", b"Memes of Wowo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/af5aea56-82ad-4b2d-8698-46daa6b4ea0e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOWO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WOWO>>(v1);
    }

    // decompiled from Move bytecode v6
}

