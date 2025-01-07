module 0x77dd4cdd171bf7b5d5103ef8984cac8423c41e447801d6fa8b6e2792cea14206::trololo {
    struct TROLOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TROLOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TROLOLO>(arg0, 9, b"TROLOLO", b"Trololo", b"Mr. Trololo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aa8276f1-df49-48eb-9924-fa41a26317c7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TROLOLO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TROLOLO>>(v1);
    }

    // decompiled from Move bytecode v6
}

