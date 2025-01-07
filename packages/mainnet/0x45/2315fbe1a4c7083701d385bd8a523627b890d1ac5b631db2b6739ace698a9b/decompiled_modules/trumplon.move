module 0x452315fbe1a4c7083701d385bd8a523627b890d1ac5b631db2b6739ace698a9b::trumplon {
    struct TRUMPLON has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPLON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPLON>(arg0, 9, b"TRUMPLON", b"Trump Elon", b"This token Trump n Elon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/321d06d3-c925-4e95-bc32-fa4b6bcb6c47.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPLON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPLON>>(v1);
    }

    // decompiled from Move bytecode v6
}

