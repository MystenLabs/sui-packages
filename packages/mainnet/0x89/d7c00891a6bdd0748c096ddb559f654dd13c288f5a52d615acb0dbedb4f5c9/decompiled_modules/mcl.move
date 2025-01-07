module 0x89d7c00891a6bdd0748c096ddb559f654dd13c288f5a52d615acb0dbedb4f5c9::mcl {
    struct MCL has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCL>(arg0, 9, b"MCL", b"Mechanical", b"It is a Mechanical world join to this world", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/817d4c69-5b61-485f-b673-621d7f87a817.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCL>>(v1);
    }

    // decompiled from Move bytecode v6
}

