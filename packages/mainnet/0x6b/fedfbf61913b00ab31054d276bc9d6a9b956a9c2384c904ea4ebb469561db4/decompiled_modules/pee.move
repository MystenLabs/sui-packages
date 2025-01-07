module 0x6bfedfbf61913b00ab31054d276bc9d6a9b956a9c2384c904ea4ebb469561db4::pee {
    struct PEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEE>(arg0, 9, b"PEE", b"palm tree", b"like the beach", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/baa5fdd3-bf39-4adf-8f49-75858f86488c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

