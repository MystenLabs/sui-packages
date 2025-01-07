module 0x26d74264845ce592d7fd635408a3c667d450344bfc3e6214ded7304a0edefe04::dhxndn {
    struct DHXNDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DHXNDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DHXNDN>(arg0, 9, b"DHXNDN", b"Dkfhdmd", b"Cncjmc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d4b32fd9-d05b-4569-a29a-b518c6187787.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DHXNDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DHXNDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

