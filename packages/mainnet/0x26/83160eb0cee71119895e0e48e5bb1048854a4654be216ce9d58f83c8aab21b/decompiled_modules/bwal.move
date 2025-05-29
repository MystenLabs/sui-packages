module 0x2683160eb0cee71119895e0e48e5bb1048854a4654be216ce9d58f83c8aab21b::bwal {
    struct BWAL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BWAL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BWAL>(arg0, 6, b"Bwal", b"Baby Walrus", b"Baby Walrus is a meme token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748511204498.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BWAL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BWAL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

