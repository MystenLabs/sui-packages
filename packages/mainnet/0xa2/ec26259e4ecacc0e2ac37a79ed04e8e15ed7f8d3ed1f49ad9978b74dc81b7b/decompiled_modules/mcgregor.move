module 0xa2ec26259e4ecacc0e2ac37a79ed04e8e15ed7f8d3ed1f49ad9978b74dc81b7b::mcgregor {
    struct MCGREGOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCGREGOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCGREGOR>(arg0, 9, b"MCGREGOR", b"McGreConor", b"Official coin of Conor Anthony McGregor", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/335a0986-5faf-4962-aea0-ac38637e3667.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCGREGOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MCGREGOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

