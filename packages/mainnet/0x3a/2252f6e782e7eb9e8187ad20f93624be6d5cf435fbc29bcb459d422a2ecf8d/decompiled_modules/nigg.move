module 0x3a2252f6e782e7eb9e8187ad20f93624be6d5cf435fbc29bcb459d422a2ecf8d::nigg {
    struct NIGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: NIGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NIGG>(arg0, 9, b"NIGG", b"BLACK", b"NIG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/23df14c6-8623-4e5e-a6ce-5c64bb36243b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NIGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

