module 0x3a7e7c55441d6ab38b3ccf37bccc5a2f87d8e76cbebe282cdbf497cae5064583::YOLO {
    struct YOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOLO>(arg0, 9, b"TRUMP", b"Trump Elon", b"Trump Elon usa", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<YOLO>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOLO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOLO>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

