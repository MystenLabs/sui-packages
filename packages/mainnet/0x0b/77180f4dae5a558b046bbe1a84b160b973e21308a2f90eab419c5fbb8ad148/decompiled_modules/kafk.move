module 0xb77180f4dae5a558b046bbe1a84b160b973e21308a2f90eab419c5fbb8ad148::kafk {
    struct KAFK has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAFK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAFK>(arg0, 9, b"KAFK", b"kafka", b"Franz kafka", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/58c68626-64e3-48e5-8649-b2f2b9ceea37.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAFK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAFK>>(v1);
    }

    // decompiled from Move bytecode v6
}

