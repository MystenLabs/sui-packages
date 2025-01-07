module 0x6b1c0c004aeddf6553071b7e31f174685a66a72192b3277a813c50c631bef273::yolo {
    struct YOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOLO>(arg0, 6, b"YOLO", b"YOLOSUI", b"YoloSui (YOLO): The token for those who live boldly, on the Sui network. Join the movement!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731432990177.26")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOLO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YOLO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

