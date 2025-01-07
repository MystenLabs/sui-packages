module 0xec6ff3646631fd3e85f5a82b8b0bbda459ffc7bfcece351a3fe9dae75d9c73bf::donateloai {
    struct DONATELOAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONATELOAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONATELOAI>(arg0, 6, b"DONATELOAI", b"DONATELO AI", b"$DONATELOAI is an innovative project inspired by Donatello, the iconic ninja turtle with a passion for technology, which combines futuristic elements with the power of artificial intelligence (AI). This project seeks to position itself as a cryptocur", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736078204845.15")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONATELOAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONATELOAI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

