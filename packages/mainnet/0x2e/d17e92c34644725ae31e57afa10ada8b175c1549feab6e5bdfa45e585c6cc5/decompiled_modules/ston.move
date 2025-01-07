module 0x2ed17e92c34644725ae31e57afa10ada8b175c1549feab6e5bdfa45e585c6cc5::ston {
    struct STON has drop {
        dummy_field: bool,
    }

    fun init(arg0: STON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STON>(arg0, 9, b"STON", b"river ston", b"river stone power", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6c8a8644-c883-4f91-a3ac-696657945a8d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STON>>(v1);
    }

    // decompiled from Move bytecode v6
}

