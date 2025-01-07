module 0x208b149088340fc40d775778c4d33a1bbb3f3c858fe60c6bb08fbda830feb491::swah {
    struct SWAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWAH>(arg0, 6, b"SWAH", b"Swah", x"5468652073706c61736869657374206d656d65636f696e2061726f756e6421204469766520696e746f2066756e2c207761766573206f66206c617567687465722c20616e6420656e646c65737320706f73736962696c69746965732e20f09f8c8ae29ca8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732053033471.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWAH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWAH>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

