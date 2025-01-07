module 0xd9c865f8488f41c58f3b58219162ed55b0a80ee648f863603edc30571a9fcdb6::pawsamoto {
    struct PAWSAMOTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWSAMOTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWSAMOTO>(arg0, 6, b"PAWSAMOTO", b"Satoshi Pawsamoto Sui", x"5361746f7368692050617773616d6f746f2c20746865206c6567656e64617279206f72616e67652d7461626279206361742c20697320617420746865206865617274206f662074686520394c494645206d656d6520756e6976657273650a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Satoshi_Pawsamoto_Sui_41fcc84b03.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWSAMOTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAWSAMOTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

