module 0xb4c891edfacc8ee240970770a46bd0ea8fc619f5e5d0e8cc4e2df7670d6dd6a1::suis {
    struct SUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIS>(arg0, 6, b"Suis", b"Suisage", b"Tasty sausage meme from the Sui kitchen ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tg_f69d5ef194.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIS>>(v1);
    }

    // decompiled from Move bytecode v6
}

