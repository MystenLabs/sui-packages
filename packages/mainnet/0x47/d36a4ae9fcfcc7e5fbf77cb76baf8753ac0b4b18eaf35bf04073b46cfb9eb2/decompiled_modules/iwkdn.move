module 0x47d36a4ae9fcfcc7e5fbf77cb76baf8753ac0b4b18eaf35bf04073b46cfb9eb2::iwkdn {
    struct IWKDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: IWKDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IWKDN>(arg0, 9, b"IWKDN", b"kenen", b"behe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d8e2dd3b-e379-4b8a-8879-0c5db98082d5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IWKDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IWKDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

