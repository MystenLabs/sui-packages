module 0xaf865f95386d2a82fbed77d2b2aae1700dc8235c10e015a0f1ff9e98fe2ebab6::ma {
    struct MA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MA>(arg0, 9, b"MA", b"MederAjij", b"meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0a9df5f3-ef98-4876-9882-ab564f598276.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MA>>(v1);
    }

    // decompiled from Move bytecode v6
}

