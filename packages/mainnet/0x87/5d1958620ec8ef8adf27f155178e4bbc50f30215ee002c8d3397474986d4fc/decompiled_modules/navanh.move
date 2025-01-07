module 0x875d1958620ec8ef8adf27f155178e4bbc50f30215ee002c8d3397474986d4fc::navanh {
    struct NAVANH has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAVANH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAVANH>(arg0, 9, b"NAVANH", b"DAN", b"My baby", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3601b5eb-d351-4249-9d83-546fed4ddbb4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAVANH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAVANH>>(v1);
    }

    // decompiled from Move bytecode v6
}

