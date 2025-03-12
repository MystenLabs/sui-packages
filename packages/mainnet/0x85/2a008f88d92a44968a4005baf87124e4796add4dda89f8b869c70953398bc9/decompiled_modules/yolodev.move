module 0x852a008f88d92a44968a4005baf87124e4796add4dda89f8b869c70953398bc9::yolodev {
    struct YOLODEV has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOLODEV, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://yolo-hola-dev.s3.amazonaws.com/uploads/1741776204217.jpeg"));
        let (v1, v2) = 0x2::coin::create_currency<YOLODEV>(arg0, 6, b"YD", b"YoloDev", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOLODEV>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YOLODEV>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<YOLODEV>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<YOLODEV>>(arg0);
    }

    // decompiled from Move bytecode v6
}

