module 0x8dbf47b27df49f82c1b137f3b13aabdfa052ae8132c545d7df020a196cba09fc::steez {
    struct STEEZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: STEEZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STEEZ>(arg0, 9, b"STEEZ", b"ROBAN", b"I can't even lie for you bro", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b550616e-e504-4521-928e-bba2a29aef3b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STEEZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STEEZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

