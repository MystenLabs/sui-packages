module 0xec3092eeba74519c1ed0964d3cbcaeea960e61a7c4ba8570272069fbaf0d4759::bnalley {
    struct BNALLEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNALLEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNALLEY>(arg0, 9, b"BNALLEY", b"BillizNall", b"Bnalley on Sui Ecosystem ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3ea93fc0-e028-43e4-a03d-554668f8541e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNALLEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BNALLEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

