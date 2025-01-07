module 0x4ab90260afe2f9af11992a831eba45dce482e438f754ae2941f97161d1ef4d31::send {
    struct SEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SEND>(arg0, 6, b"bSEND", b"beta SEND", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://suilend-assets.s3.us-east-2.amazonaws.com/SEND/SEND.svg")), true, arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEND>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SEND>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

