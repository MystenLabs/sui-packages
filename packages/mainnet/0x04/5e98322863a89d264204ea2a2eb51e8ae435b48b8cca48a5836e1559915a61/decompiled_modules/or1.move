module 0x45e98322863a89d264204ea2a2eb51e8ae435b48b8cca48a5836e1559915a61::or1 {
    struct OR1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: OR1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OR1>(arg0, 9, b"OR1", b"OR1YO ", b"Reliable for fast transaction ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cd49664c-11ea-411d-a857-87233de2e4b9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OR1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OR1>>(v1);
    }

    // decompiled from Move bytecode v6
}

