module 0xc2190ca4bec5b2d0879e8ecd910cc66007070516c2d8c9d2058be89266138559::shand {
    struct SHAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAND>(arg0, 6, b"SHAND", b"Suihand", x"5448452043484f494345204953204f4e4c5920494e20594f55522048414e44530a4275742053554948414e44206265636f6d657320746865206d6f737420676f6c64656e20616e64206469616d6f6e642068616e6420746f20626520612073746570206f66207375636365737320616e642067726561742070726f666974200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055324_adc3715e61.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHAND>>(v1);
    }

    // decompiled from Move bytecode v6
}

