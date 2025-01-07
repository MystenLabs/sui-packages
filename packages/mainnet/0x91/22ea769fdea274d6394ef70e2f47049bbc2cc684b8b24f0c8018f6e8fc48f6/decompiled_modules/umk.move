module 0x9122ea769fdea274d6394ef70e2f47049bbc2cc684b8b24f0c8018f6e8fc48f6::umk {
    struct UMK has drop {
        dummy_field: bool,
    }

    fun init(arg0: UMK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UMK>(arg0, 9, b"UMK", b"UMKA", b"UMKA is a meme inspired by the spirit of adventure and freedom. With UMK, we are not just riding the waves - we are mastering them!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7519fb7f-12b5-4767-ba16-d47dea3e02bf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UMK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UMK>>(v1);
    }

    // decompiled from Move bytecode v6
}

