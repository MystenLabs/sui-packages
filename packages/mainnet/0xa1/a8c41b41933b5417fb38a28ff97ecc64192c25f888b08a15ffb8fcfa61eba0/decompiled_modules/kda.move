module 0xa1a8c41b41933b5417fb38a28ff97ecc64192c25f888b08a15ffb8fcfa61eba0::kda {
    struct KDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KDA>(arg0, 9, b"KDA", b"Kudai", b"Meme token on sui Blockchain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dfd88e30-8c82-448f-a9e3-65530be0466a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KDA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KDA>>(v1);
    }

    // decompiled from Move bytecode v6
}

