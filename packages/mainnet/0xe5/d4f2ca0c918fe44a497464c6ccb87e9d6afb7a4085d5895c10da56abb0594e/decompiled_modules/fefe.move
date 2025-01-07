module 0xe5d4f2ca0c918fe44a497464c6ccb87e9d6afb7a4085d5895c10da56abb0594e::fefe {
    struct FEFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEFE>(arg0, 6, b"FEFE", b"FEFE BY MATT FURIE", b"FEFE follows along his friends in the Mindviscosity universe by Matt Furie. His free spirit and adventurous nature prove to be an inspiration for all of his friends.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/76_228e243de9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FEFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

