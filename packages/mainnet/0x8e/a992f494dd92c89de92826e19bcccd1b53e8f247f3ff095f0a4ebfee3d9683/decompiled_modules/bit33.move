module 0x8ea992f494dd92c89de92826e19bcccd1b53e8f247f3ff095f0a4ebfee3d9683::bit33 {
    struct BIT33 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIT33, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIT33>(arg0, 9, b"Bit33", b"Bitcoin", x"42697433330a42697433332041492028536f6372617465732920746865206167656e74206c61756e636870616420616e64206f726368657374726174696f6e206c6179657220666f72206167656e747320737761726d7320616e64206b6e6f776c65646765206261736573", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/bb4e663f3e82676be14f5d7ab655b90bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIT33>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIT33>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

