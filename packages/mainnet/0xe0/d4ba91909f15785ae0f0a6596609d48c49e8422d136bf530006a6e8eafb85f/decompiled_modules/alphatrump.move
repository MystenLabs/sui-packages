module 0xe0d4ba91909f15785ae0f0a6596609d48c49e8422d136bf530006a6e8eafb85f::alphatrump {
    struct ALPHATRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALPHATRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALPHATRUMP>(arg0, 6, b"ALPHATRUMP", b"AlphaTrump On Sui", b"TRUMP is an Alpha , no cap ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000155178_946d937acb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALPHATRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ALPHATRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

