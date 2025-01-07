module 0xe929e354ebc9eadb1fb36c05ce659d76d5a72638dc0b9ae317e6c52e4d5c4769::weus {
    struct WEUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEUS>(arg0, 9, b"WEUS", b"US", b"US is a meme inspired by the spirit of adventure and freedom. With US, we are not just riding the waves we are mastering them!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/20e9f240-8bf1-4fd9-b73c-43cf7bf7a542.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

