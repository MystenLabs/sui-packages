module 0xa6605db095096356e994d1245f4f9e7eade87812ff8a85d64f9df1ce63b3333a::fyre {
    struct FYRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FYRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FYRE>(arg0, 6, b"FYRE", b"Its FYRE", b"A tiny FYRE flame with boundless ambition, ready to ignite the dying Trenches back to its glory.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihsakltvlmf5kvscxbiiwxwyex7xoz42ey24ykmqzgytaqlaaudsq")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FYRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FYRE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

