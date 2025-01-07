module 0x265c9874c76bb585a7478de8defdb043caacd76a1d14bbe316f7f15057186040::tuk {
    struct TUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUK>(arg0, 9, b"TUK", b"Tucker", b"A nice project ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7d9a1c8d-0213-41ba-83e2-87637aa9f1e2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

