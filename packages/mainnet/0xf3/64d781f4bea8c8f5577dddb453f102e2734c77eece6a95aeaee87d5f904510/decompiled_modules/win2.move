module 0xf364d781f4bea8c8f5577dddb453f102e2734c77eece6a95aeaee87d5f904510::win2 {
    struct WIN2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: WIN2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WIN2>(arg0, 9, b"WIN2", b"Winner2", b"Winner of web3 2", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ac217d18-5b4f-49dc-b5c7-9753c03fcf3a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WIN2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WIN2>>(v1);
    }

    // decompiled from Move bytecode v6
}

