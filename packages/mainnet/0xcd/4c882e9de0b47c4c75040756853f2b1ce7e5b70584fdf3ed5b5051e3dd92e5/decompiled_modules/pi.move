module 0xcd4c882e9de0b47c4c75040756853f2b1ce7e5b70584fdf3ed5b5051e3dd92e5::pi {
    struct PI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PI>(arg0, 6, b"PI", b"PI Sui", b"Official PI Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000079_46a4c6dc7a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PI>>(v1);
    }

    // decompiled from Move bytecode v6
}

