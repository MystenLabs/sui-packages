module 0xf4caca020d096cf8fba4c3018d64f5e480b2223d7b5b1cd4655376f7d7c70db6::pwaty {
    struct PWATY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PWATY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PWATY>(arg0, 6, b"PWATY", b"Pwaty On Sui", b"Pwaty the cute penguin that will become an icon on the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015607_76f99267e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PWATY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PWATY>>(v1);
    }

    // decompiled from Move bytecode v6
}

