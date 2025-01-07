module 0xe81ad4f1fa672017e7300eb8741a5a1f65127026a70d57bf282095fcf0dbc009::oggyonsui {
    struct OGGYONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: OGGYONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OGGYONSUI>(arg0, 6, b"OGGYONSUI", b"OGGYY", x"4f4747592048454c4c4f2054484520574f524c440a57656c636f6d6520746f204f676779206120636f6d6d756e6974792064726976656e2070726f6a656374", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/imagem_2024_10_11_203221028_c186c64d06.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OGGYONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OGGYONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

