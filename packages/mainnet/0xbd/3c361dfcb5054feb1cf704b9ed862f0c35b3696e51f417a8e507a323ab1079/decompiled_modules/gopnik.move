module 0xbd3c361dfcb5054feb1cf704b9ed862f0c35b3696e51f417a8e507a323ab1079::gopnik {
    struct GOPNIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOPNIK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOPNIK>(arg0, 6, b"GOPNIK", b"Sui Gopnik", b"Cool frog is GOPNIK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000011623_858e2e19e5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOPNIK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOPNIK>>(v1);
    }

    // decompiled from Move bytecode v6
}

