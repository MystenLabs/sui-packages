module 0x96229e92ee095e98d27fa309b9fe689fa183fff368078213eb16d6aa04fe106d::ufo {
    struct UFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: UFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UFO>(arg0, 9, b"UFO", b"M00F0", x"6d6f6f666f2069732074686520756c74696d617465206d656d65206675656c2066726f6d206d6f6f666f6c6f677920e280942074686520706c61736d612067616d652077686572652075666f73206265616d20636f77732e20686f6c64657273206a6f696e2074686520686572642c20756e6c6f636b2073656372657420636f77732c20736b696e732026206368616f732e206e6f20626f72696e67206d6174682c206a7573742070757265206d6f6f6d656e74756d2e206d6f6f20686172642c206d6f6f206c6f75642c206d6f6f20746f67657468657220e2809420616e64206c6574e28099732061626475637420746865206d6f6f6e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<UFO>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UFO>>(v2, @0xfd8a361d1b7089cb77cf30a47d1818184527ce2a149492c6d9e818fa7ead13e6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UFO>>(v1);
    }

    // decompiled from Move bytecode v6
}

