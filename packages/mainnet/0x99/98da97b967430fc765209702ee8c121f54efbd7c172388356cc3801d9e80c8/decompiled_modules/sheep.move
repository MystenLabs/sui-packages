module 0x9998da97b967430fc765209702ee8c121f54efbd7c172388356cc3801d9e80c8::sheep {
    struct SHEEP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHEEP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHEEP>(arg0, 6, b"Sheep", b"SHEEP", x"424c5545204c494b452053554920414e44205748495445204c494b4520434c4f5544530a574954482024534845455020534b5920495320544845204c494d4954", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a1w_Cjbn_400x400_20adacfd84.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHEEP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHEEP>>(v1);
    }

    // decompiled from Move bytecode v6
}

