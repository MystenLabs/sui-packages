module 0x8c275079dbfd3742fca6823fe08e474a942b4b47a5ac0b547f6233c0f87d5415::dawg {
    struct DAWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAWG>(arg0, 9, b"DAWG", b"DAWG Coin", b"Who are you dawg?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1c4e4f15-a033-48ec-b939-4636cdcfe6be.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAWG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAWG>>(v1);
    }

    // decompiled from Move bytecode v6
}

