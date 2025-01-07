module 0x310432430563aa6bd27af2e4e4752ba6fcf3426af7b49e60fe250e0ba868f813::sadcat {
    struct SADCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SADCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SADCAT>(arg0, 9, b"SADCAT", b"sad cat", b"sad cat in the couch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ed670bd8-4f39-401c-a552-4298bf44478c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SADCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SADCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

