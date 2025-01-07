module 0xf16e6b723f242ec745dfd7634ad072c42d5c1d9ac9d62a39c381303eaa57693a::fdusd {
    struct FDUSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: FDUSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency<FDUSD>(arg0, 6, b"FDUSD", b"First Digital USD", b"First Digital USD", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.1stdigital.com/icon/fdusd.svg")), arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FDUSD>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FDUSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCap<FDUSD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

