module 0xb752c6da20aa1e467f24f79ec02151ea533824c1ac5a419a2bc56db77ca6fb58::hpy {
    struct HPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HPY>(arg0, 6, b"HPY", b"Hoppy", x"0a486f707079204f6e205355492077696c6c206d616b6520796f75206861707079", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/R34_S_KQ_400x400_156bdefc69.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

