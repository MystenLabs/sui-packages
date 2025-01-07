module 0xb87f46c7071643b9f8dbcf871c8ec49fe97c5bdc5c2032bd98a3f27a27f85621::qubit {
    struct QUBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: QUBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<QUBIT>(arg0, 6, b"QUBIT", b"Qubit Ai", x"517562697420546f6b656e20697320612073746174652d6f662d7468652d6172742063727970746f63757272656e63792064657369676e656420746f20737570706f727420746865207365727669636573206f662051756269742041492e20546865207072696d61727920676f616c206f6620517562697420546f6b656e20697320746f2070726f766964652075736572732077697468207574696c6974792077697468696e207468652051756269742041492065636f73797374656d2c200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000047885_a8cbb94d33.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QUBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QUBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

