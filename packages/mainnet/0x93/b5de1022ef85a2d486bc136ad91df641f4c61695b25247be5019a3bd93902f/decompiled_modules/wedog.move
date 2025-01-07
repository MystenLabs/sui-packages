module 0x93b5de1022ef85a2d486bc136ad91df641f4c61695b25247be5019a3bd93902f::wedog {
    struct WEDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEDOG>(arg0, 9, b"WEDOG", b"WAVEDOG ", b"The one and only WeDog on Sui Blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/78b6be6a-4b33-4d83-9fc9-ac3fadf2d059.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

