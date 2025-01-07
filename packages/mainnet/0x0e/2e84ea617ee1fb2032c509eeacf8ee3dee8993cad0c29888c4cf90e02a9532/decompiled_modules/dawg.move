module 0xe2e84ea617ee1fb2032c509eeacf8ee3dee8993cad0c29888c4cf90e02a9532::dawg {
    struct DAWG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAWG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAWG>(arg0, 9, b"DAWG", b"DAWG Coin", b"Who are you dawg?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/79cd4360-250c-4368-8995-2f41203dcbb3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAWG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAWG>>(v1);
    }

    // decompiled from Move bytecode v6
}

