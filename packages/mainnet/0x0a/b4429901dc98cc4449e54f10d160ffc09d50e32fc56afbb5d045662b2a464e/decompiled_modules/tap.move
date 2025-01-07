module 0xab4429901dc98cc4449e54f10d160ffc09d50e32fc56afbb5d045662b2a464e::tap {
    struct TAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAP>(arg0, 9, b"TAP", b"TAPsapiens", b"A new kind of human development. TAP sapiens. The time of origin is the 21st century of our era.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b3299a73-1d08-410d-8cec-d5cfad59f93d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

