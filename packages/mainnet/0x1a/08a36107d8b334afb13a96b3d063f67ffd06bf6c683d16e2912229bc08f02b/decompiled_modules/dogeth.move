module 0x1a08a36107d8b334afb13a96b3d063f67ffd06bf6c683d16e2912229bc08f02b::dogeth {
    struct DOGETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGETH>(arg0, 6, b"DOGETH", b"dogeth", b"doooooooooooooo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/IbMEY-a0fR7PYWGObAnuMZNfIDHjGlytXISh-dpxcho")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<DOGETH>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGETH>>(v2, @0x703cd1c1f68d239745a177b522a2f8651e8f8cd86e91ad9322cbec99b204ce38);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGETH>>(v1);
    }

    // decompiled from Move bytecode v6
}

