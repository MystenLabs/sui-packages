module 0x854162aa52f163396f56fa7db3e44db41c2bb417c13fa9b26cbe260f5a9def49::bro {
    struct BRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRO>(arg0, 9, b"BRO", b"Hnt", b"It's just fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/07f889bd-9c78-415b-be67-4b045c7fcf47.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

