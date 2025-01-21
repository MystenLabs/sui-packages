module 0xa6208b84c4873c01449be860818212992714c09ab20ce15bf3f2a62fb3e136ea::plankz {
    struct PLANKZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLANKZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLANKZ>(arg0, 6, b"PLANKZ", b"Plankz", b"Welcome to the new digital era where AI thrives to make you a winner. Chum Studios proudly presents $Plankz, the most vital creature in the Sea, elevating AI technology to unprecedented heights on the Sui Chain! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Plankz_222_2f6d998f45.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLANKZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLANKZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

