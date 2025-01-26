module 0x557501e8c0d0896aa17dfe3cdb75b67255bfd8a8d403bc8d85a4c270a7cde33f::pat {
    struct PAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<PAT>(arg0, 6, b"PAT", b"Pat Cat by SuiAI", b"$PAT The Degenerate Cat -", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_2257_5fdc6b2556.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PAT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

