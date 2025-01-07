module 0xe93aaa993c53763f2e0d2566d1c66f9284c3520ca2307297522c2b4d6bef586e::bean {
    struct BEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAN>(arg0, 9, b"BEAN", b" Bean Coin", b"Join the fun as Mr. Bean brings laughter to the blockchain! $BEANCOIN offers exclusive content, community perks, and a unique blend of humor and utility.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/804986c0-1d20-4069-a4f4-bb832d4a1540.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

