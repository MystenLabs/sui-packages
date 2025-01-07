module 0x1a14528eef713ae4f6b3a7369fa4182adfbeae9bd340a73327354ce3cfb5dc5b::suisei {
    struct SUISEI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISEI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISEI>(arg0, 6, b"SUISEI", b"HOSHIMACHI SUISEI", b"Dedicated to SUISEI. We will Moon This along with SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suityan_90eb5b6f8d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISEI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISEI>>(v1);
    }

    // decompiled from Move bytecode v6
}

