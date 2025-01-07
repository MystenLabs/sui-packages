module 0x61cc3cfa61fe94701efe47cef671ad1b8170fcbdbb34048c956c9622ce739149::teddy {
    struct TEDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEDDY>(arg0, 9, b"TEDDY", b"Mr. Bean", b"Mr. Bean is a beloved British comedy character known for his childlike antics and hilarious misadventures. He rarely speaks, relying on physical comedy and facial expressions to convey his thoughts and emotions.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c2b6bd73-e5ca-4123-8833-1e5c739d6f72.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

