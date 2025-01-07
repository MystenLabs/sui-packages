module 0xd0e3c6087d543c7c222e78f8e7ad2d76435a8da282ab0aeeaea7e72ad1515989::bepe {
    struct BEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEPE>(arg0, 6, b"BEPE", b"BEPE ON SUI", x"426f6f622070657065206265706520746865206d0a4e657874206d696c6c696f6e206f66206d656d65636f696e2042657065", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000039858_842d040398.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

