module 0x7d671f8d0ff42fe5b4118b704b03ee55e00cd679abf09f5a2dc1a4fc97d72c43::frenchie {
    struct FRENCHIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FRENCHIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FRENCHIE>(arg0, 6, b"Frenchie", b"Cool Frenchie", b"Hey. I am a cool dog Frenchie. I am a community token. As a Dev I buy 10%. Some burn some airdrop. Join me on telegram, I need team.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c2673a93da7691759c8676901f7e563a_6544487612.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FRENCHIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FRENCHIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

