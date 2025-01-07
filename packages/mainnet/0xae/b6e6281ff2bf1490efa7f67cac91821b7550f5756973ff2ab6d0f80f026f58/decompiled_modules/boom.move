module 0xaeb6e6281ff2bf1490efa7f67cac91821b7550f5756973ff2ab6d0f80f026f58::boom {
    struct BOOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOM>(arg0, 6, b"BOOM", b"BOOM ON SUI", b"BOOM is a meme token in the Sui ecosystem created for loud ideas and bold actions! With BOOM, users can support each other in the pursuit of free speech and independence. It is not just a token, but a symbol of energy and strength that unites like-mi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730950760351.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

