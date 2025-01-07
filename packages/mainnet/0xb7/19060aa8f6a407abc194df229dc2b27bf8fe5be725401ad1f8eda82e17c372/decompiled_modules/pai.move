module 0xb719060aa8f6a407abc194df229dc2b27bf8fe5be725401ad1f8eda82e17c372::pai {
    struct PAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAI>(arg0, 6, b"PAI", b"PoseidonAI", x"506f736569646f6e41490a5761766573206f6620414920746f6f6c73", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/poss1_3380fd0975.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

