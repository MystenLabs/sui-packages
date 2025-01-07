module 0x69844df0d51efd02e1a0d258d894ef5c0d3ab8af9ce33f5b6001966bb4aebe23::fd {
    struct FD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FD>(arg0, 6, b"FD", b"FrogDog", x"46726f6720646f672069732074686520536861726b20636174206f66207375690a0a4644200a54672077696c6c206265206d61646520696620636f6d6d756e69747920646563696465732e200a4c65742773206d616b652074686973206120636f6d6d756e69747920636f696e2068657265206f6e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000014644_de99c88e42.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FD>>(v1);
    }

    // decompiled from Move bytecode v6
}

