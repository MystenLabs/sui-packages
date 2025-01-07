module 0xcc95e0c3163fa528d0c1e6ebf5e033d4611f80b3ad5316d4c30008a0bc0d82e8::dam {
    struct DAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAM>(arg0, 9, b"DAM", b"DAMUNAA", b"ADEAA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cfc4a1ee-7107-4956-a079-4cd4c3c76a99.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

