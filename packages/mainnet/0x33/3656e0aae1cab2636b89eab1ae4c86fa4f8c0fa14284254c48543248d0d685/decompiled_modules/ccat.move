module 0x333656e0aae1cab2636b89eab1ae4c86fa4f8c0fa14284254c48543248d0d685::ccat {
    struct CCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCAT>(arg0, 9, b"CCAT", b"CUTE CAT", x"4661737420616e642064617a7a6c696e67206272616e640a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/93df65c0-a884-4a31-902c-8e7814c81b84.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

