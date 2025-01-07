module 0xa24d98637613686c2ca856a2e008630a7da48fdc74bb8385f949f3a1cf565e00::saigojo {
    struct SAIGOJO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAIGOJO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAIGOJO>(arg0, 9, b"SAIGOJO", b"Gojo", b"Just try it....plz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b701fca8-e8e1-42f1-a302-e287dd2f9e77.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAIGOJO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAIGOJO>>(v1);
    }

    // decompiled from Move bytecode v6
}

