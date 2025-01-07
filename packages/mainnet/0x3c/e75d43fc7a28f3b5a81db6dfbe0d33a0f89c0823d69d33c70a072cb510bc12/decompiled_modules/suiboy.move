module 0x3ce75d43fc7a28f3b5a81db6dfbe0d33a0f89c0823d69d33c70a072cb510bc12::suiboy {
    struct SUIBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOY>(arg0, 6, b"SUIBOY", b"Sui Boy", b"Meet Sui Boy, a truly original character in a world full of copycats.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0907_1_1_37969778d5.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

