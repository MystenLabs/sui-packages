module 0x6210447d05d88bc7ce42c043f28de83d950dccccb42ac4facf865d8a48abaa10::yolo {
    struct YOLO has drop {
        dummy_field: bool,
    }

    fun init(arg0: YOLO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YOLO>(arg0, 9, b"YOLO", b"YOLO", b"The native token of YOLO Games.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1756966165325443072/jYx9riJ0_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YOLO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<YOLO>>(0x2::coin::mint<YOLO>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<YOLO>>(v2);
    }

    // decompiled from Move bytecode v6
}

