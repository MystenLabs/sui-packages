module 0xbdd03999767d1092e7730c06296ea15d89c373c2249cbefd77409cfc04e1ae25::bdoge {
    struct BDOGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BDOGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BDOGE>(arg0, 6, b"BDOGE", b"BLUE DOGECOIN", x"5468697320424c554520444f47452c204372656174656420627920616e6f6e696d6f757320746f20436f6d756e6e6974790a6372656174656420746f206265207468652062696767657374206d656d65", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bluedoge_3fdb8bdde8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BDOGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BDOGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

