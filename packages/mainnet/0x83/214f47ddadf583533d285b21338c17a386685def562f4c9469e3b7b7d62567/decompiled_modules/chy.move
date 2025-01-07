module 0x83214f47ddadf583533d285b21338c17a386685def562f4c9469e3b7b7d62567::chy {
    struct CHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHY>(arg0, 9, b"CHY", b"Chicky", x"436c75636b20696e746f2063727970746f207769746820436869636b79436f696e3a20546865206567672d636974696e672063757272656e6379207468617427732072756c696e672074686520726f6f7374207769746820706f756c7472792d706f77657265642070726f6669747320616e64206665617468657265642066756e2120f09f90a5f09f92b8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/294ea4dc-a156-45f0-b360-56e337f0bdd4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

