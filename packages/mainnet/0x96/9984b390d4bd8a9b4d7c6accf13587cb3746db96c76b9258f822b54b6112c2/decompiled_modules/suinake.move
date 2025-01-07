module 0x969984b390d4bd8a9b4d7c6accf13587cb3746db96c76b9258f822b54b6112c2::suinake {
    struct SUINAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINAKE>(arg0, 6, b"SUINAKE", b"Sui Snake", x"4d656574205355494e414b45202853756920536e616b652920537569732073696c656e742073657270656e7420697320686572652e204e6f206672696c6c732c206a757374207075726520626974652e0a0a0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Snake_87452463a4.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

