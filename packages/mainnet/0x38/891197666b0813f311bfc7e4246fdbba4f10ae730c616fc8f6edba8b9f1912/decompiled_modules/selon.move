module 0x38891197666b0813f311bfc7e4246fdbba4f10ae730c616fc8f6edba8b9f1912::selon {
    struct SELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: SELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SELON>(arg0, 6, b"SELON", b"SUIELON", b"Elon Musk love SUI and plan to integret SUI into the XAI platform. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3807_d64178eb1d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SELON>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SELON>>(v1);
    }

    // decompiled from Move bytecode v6
}

