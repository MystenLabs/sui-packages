module 0x996ba8b47f6d13f20fd473dc04568556565d311021d34df4abaddbb316100b5f::hung {
    struct HUNG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUNG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUNG>(arg0, 9, b"HUNG", b"VanHung", b"my name", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a3e77e2a-6cd9-490b-864f-3cd8c469c27f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUNG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUNG>>(v1);
    }

    // decompiled from Move bytecode v6
}

