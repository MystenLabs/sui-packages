module 0x2f7d8052193841d990cdae2ec644fe7714818e78e0115857ab830df9e508a098::kolz {
    struct KOLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOLZ>(arg0, 6, b"KOLZ", b"KOLZ ON SUI", x"57414e5420544f2053454520484f57204c41554e4348494e4720412050524f4a454354204645454c53200a0a4c4f4c", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihiwdvyzfb4irjwy6fttkdrw7xlozmuxs6ows5n57kriwhycq53z4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOLZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<KOLZ>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

