module 0x7f459b94624bd54280f2f4dada5e30c0722ad63b4529049b95a851085282d840::tada {
    struct TADA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TADA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TADA>(arg0, 9, b"TADA", b"TADA COIN", b"Inspired by community of people who have passion in adventure and love to travel. TADA COIN is a way to tokenize the transportation industry and unleash a new ride-hailing  era", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e35b3bd8-9615-4173-b229-9a5bc33f0e24.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TADA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TADA>>(v1);
    }

    // decompiled from Move bytecode v6
}

