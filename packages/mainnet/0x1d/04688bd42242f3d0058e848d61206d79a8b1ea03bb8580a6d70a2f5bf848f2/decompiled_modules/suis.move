module 0x1d04688bd42242f3d0058e848d61206d79a8b1ea03bb8580a6d70a2f5bf848f2::suis {
    struct SUIS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIS>(arg0, 6, b"Suis", b"Suishi", b"See yoo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1748529012661.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

