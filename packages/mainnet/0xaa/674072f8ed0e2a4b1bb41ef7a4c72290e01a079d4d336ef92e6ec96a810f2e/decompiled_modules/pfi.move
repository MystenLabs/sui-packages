module 0xaa674072f8ed0e2a4b1bb41ef7a4c72290e01a079d4d336ef92e6ec96a810f2e::pfi {
    struct PFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PFI>(arg0, 6, b"PFI", b"PFIDA", b"PFIDA Solutions on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreietrhruyv47z36hv5z5lkwplo7fxmyjlh7f6tj72vt3qirowe2jre")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PFI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

