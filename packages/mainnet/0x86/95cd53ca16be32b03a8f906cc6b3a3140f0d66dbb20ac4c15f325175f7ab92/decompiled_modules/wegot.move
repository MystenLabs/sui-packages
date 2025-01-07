module 0x8695cd53ca16be32b03a8f906cc6b3a3140f0d66dbb20ac4c15f325175f7ab92::wegot {
    struct WEGOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEGOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEGOT>(arg0, 9, b"WEGOT", b"WAWE", b"WAWE is a meme inspired by the spirit of adventure and freedom with WAWE, we are not just riding the waves - we are mastering them!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a3a8fcfe-ab1f-4bb4-aff7-9f3485520e80.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEGOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEGOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

