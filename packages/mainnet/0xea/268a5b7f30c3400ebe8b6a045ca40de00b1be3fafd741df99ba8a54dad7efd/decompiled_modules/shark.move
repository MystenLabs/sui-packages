module 0xea268a5b7f30c3400ebe8b6a045ca40de00b1be3fafd741df99ba8a54dad7efd::shark {
    struct SHARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHARK>(arg0, 6, b"Shark", b"Sharkonsui", x"24534841524b207375726765732066726f6d207468652024535549206f6365616e20616e6420756e6c65617368696e67206120667265736820776176650a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1500x500_2_b05fe6380c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

