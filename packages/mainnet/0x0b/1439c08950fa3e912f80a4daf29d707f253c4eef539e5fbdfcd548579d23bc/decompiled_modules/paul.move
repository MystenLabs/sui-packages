module 0xb1439c08950fa3e912f80a4daf29d707f253c4eef539e5fbdfcd548579d23bc::paul {
    struct PAUL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAUL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAUL>(arg0, 9, b"PAUL", b"TIfe", b"Tifepaul", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/650d1901-eae6-4fbd-89dc-cd0a97de04f2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAUL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAUL>>(v1);
    }

    // decompiled from Move bytecode v6
}

