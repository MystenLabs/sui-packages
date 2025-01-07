module 0x98b636ac11abbe37f9e51920bf4c1ff7867d31515d851dc1a6c62f803b8feaf2::kirbysui {
    struct KIRBYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIRBYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIRBYSUI>(arg0, 6, b"KIRBYSUI", b"Kirby on Sui", b"Our SUI Kirby is here to stay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/kirby_793ccd9292.JPEG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIRBYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIRBYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

